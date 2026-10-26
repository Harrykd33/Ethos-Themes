"""Theme catalog and transactional USB installer. Standard library only."""
from __future__ import annotations

import ctypes
from dataclasses import dataclass
from datetime import datetime, timezone
import hashlib
import io
import json
import os
from pathlib import Path
import re
import shutil
import tempfile
import urllib.error
import urllib.parse
import urllib.request
import uuid
import zipfile

REPOSITORY = "Harrykd33/Ethos-Themes"
REPO_URL = f"https://github.com/{REPOSITORY}"
BRANCH = "main"
WIZARD_REPOSITORY = "Harrykd33/Ethos-RF-Model-Wizard"
WIZARD_URL = f"https://github.com/{WIZARD_REPOSITORY}"
WIZARD_FOLDER = "rotorflight-model-wizard"
WIZARD_ARCHIVE = "rotorflight-model-wizard-standalone-en.zip"
MAX_DOWNLOAD = 16 * 1024 * 1024


@dataclass(frozen=True)
class Theme:
    key: str
    name: str
    lua: str
    assets: tuple[str, ...]
    colors: tuple[str, ...]

    @property
    def category(self):
        mode = re.search(r"\bdarkMode\s*=\s*(true|false)\b", code_mask(self.lua))
        if mode:
            return "Dark" if mode[1] == "true" else "Light"
        if len(self.colors) > 5:
            color = self.colors[5].lstrip("#")
            red, green, blue = (int(color[index:index + 2], 16) for index in (0, 2, 4))
            return "Dark" if 0.299 * red + 0.587 * green + 0.114 * blue < 128 else "Light"
        return "Light"


def categorized_themes(themes, category="All Themes"):
    if category not in ("Dark", "Light", "All Themes"):
        raise ValueError("Unknown theme category")
    return sorted((theme for theme in themes if category == "All Themes" or theme.category == category),
                  key=lambda theme: theme.name.casefold())


def code_mask(source: str) -> str:
    """Blank Lua comments/strings, preserving indices for delimiter matching."""
    token = re.compile(r"--\[(=*)\[.*?\]\1\]|--[^\n]*|\[(=*)\[.*?\]\2\]|\"(?:\\.|[^\"\\])*\"|'(?:\\.|[^'\\])*'", re.S)
    return token.sub(lambda match: " " * len(match.group()), source)


def parse_themes(source: str) -> tuple[Theme, ...]:
    mask = code_mask(source)
    themes = []
    for match in re.finditer(r"system\s*\.\s*registerTheme\s*\(\s*\{", mask):
        depth = 1
        cursor = match.end()
        while cursor < len(mask) and depth:
            depth += (mask[cursor] == "{") - (mask[cursor] == "}")
            cursor += 1
        closing = re.match(r"\s*\)", mask[cursor:])
        if depth or not closing:
            raise ValueError("Unbalanced theme registration in main.lua")
        block = source[match.start(): cursor + closing.end()]
        # Remove comments before reading metadata so disabled fields are ignored.
        clean = re.sub(r"--\[(=*)\[.*?\]\1\]|--[^\n]*", "", block, flags=re.S)
        key = re.search(r'\bkey\s*=\s*[\"\']([A-Za-z0-9_]{1,7})[\"\']', clean)
        name = re.search(r'\bname\s*=\s*[\"\']([^\"\']+)[\"\']', clean)
        if not key or not name:
            raise ValueError("Each theme needs a literal name and a key of 1–7 characters")
        assets = tuple(dict.fromkeys(re.findall(r'lcd\.loadBitmap\s*\(\s*[\"\']([^\"\']+)[\"\']\s*\)', clean)))
        for asset in assets:
            if not re.fullmatch(r"[A-Za-z0-9_.-]+\.png", asset, re.I):
                raise ValueError(f"Unsupported image path: {asset}")
        colors = parse_palette(clean)
        themes.append(Theme(key[1], name[1].strip(), block, assets, tuple(colors)))
    if not themes or len({theme.key for theme in themes}) != len(themes):
        raise ValueError("Catalog is empty or contains duplicate theme keys")
    return tuple(themes)


def parse_palette(block: str) -> list[str]:
    """Keep the Ethos palette slots, including named colors and grayscale."""
    table = re.search(r"\bcolors\s*=\s*\{([^{}]*)\}", block, re.S)
    if not table:
        return []
    number = r"(0x[\da-fA-F]+|\d+)"
    expression = re.compile(r"lcd\.RGB\(\s*" + number + r"\s*,\s*" + number + r"\s*,\s*" + number + r"\s*\)|lcd\.GREY\(\s*" + number + r"\s*\)|\b(BLACK|WHITE)\b")
    colors = []
    cursor = 0
    for match in expression.finditer(table[1]):
        if table[1][cursor:match.start()].strip(" \t\r\n,"):
            return []  # Preserve install support for expressions the preview cannot evaluate.
        if match[5]:
            rgb = (0, 0, 0) if match[5] == "BLACK" else (255, 255, 255)
        else:
            values = [int(value, 16 if value.lower().startswith("0x") else 10) for value in match.groups()[:4] if value is not None]
            rgb = tuple(values * 3 if len(values) == 1 else values)
        if any(value > 255 for value in rgb):
            raise ValueError("Theme color components must be between 0 and 255")
        colors.append("#" + "".join(f"{value:02x}" for value in rgb))
        cursor = match.end()
    if table[1][cursor:].strip(" \t\r\n,"):
        return []
    return colors


def download(url: str, *, json_response=False, progress=None):
    request = urllib.request.Request(url, headers={
        "User-Agent": "KevinD-RC-Theme-Studio/1.0",
        "Accept": "application/vnd.github+json" if json_response else "application/vnd.github.raw+json",
    })
    try:
        with urllib.request.urlopen(request, timeout=25) as response:
            total = int(response.headers.get("Content-Length", 0))
            chunks = []
            size = 0
            while chunk := response.read(64 * 1024):
                size += len(chunk)
                if size > MAX_DOWNLOAD:
                    raise ValueError("Download exceeds the 16 MB file limit")
                chunks.append(chunk)
                if progress:
                    progress(size, total)
            data = b"".join(chunks)
    except urllib.error.HTTPError as error:
        if error.code == 404:
            raise ValueError("GitHub file not found. Check that the repository and package are public on main.") from error
        if error.code in (403, 429):
            raise ValueError("GitHub request limit reached. Try again later or use bundled themes.") from error
        raise
    if len(data) > MAX_DOWNLOAD:
        raise ValueError("Download exceeds the 16 MB file limit")
    return json.loads(data) if json_response else data


@dataclass
class Catalog:
    themes: tuple[Theme, ...]
    revision: str
    local_folder: Path | None = None

    @classmethod
    def from_github(cls, report=lambda *args: None):
        report("connect", "Checking the latest GitHub commit", 0, 1)
        commit = download(f"https://api.github.com/repos/{REPOSITORY}/commits/{BRANCH}", json_response=True)["sha"]
        if not re.fullmatch(r"[0-9a-f]{40}", commit):
            raise ValueError("GitHub returned an invalid commit")
        report("download", "Downloading theme catalog", 0, 1)
        source = download(cls.asset_url("main.lua", commit), progress=lambda n, total: report("download", "Theme catalog", n, total)).decode("utf-8-sig")
        report("verify", "Reading theme packages", 1, 1)
        return cls(parse_themes(source), commit)

    @classmethod
    def from_folder(cls, folder: Path):
        source = (folder / "main.lua").read_bytes()
        revision = "bundled-" + hashlib.sha256(source).hexdigest()[:12]
        return cls(parse_themes(source.decode("utf-8-sig")), revision, folder)

    @staticmethod
    def asset_url(name, revision):
        return f"https://api.github.com/repos/{REPOSITORY}/contents/Themes/{urllib.parse.quote(name, safe='')}?ref={revision}"

    def files(self, keys: list[str], report=lambda *args: None) -> dict[str, bytes]:
        selected = [theme for theme in self.themes if theme.key in keys]
        if not selected or len(selected) != len(set(keys)):
            raise ValueError("Select at least one valid theme")
        lua = "-- Installed by Theme Studio for Ethos. Ethos 26.x.\nlocal function init()\n"
        lua += "\n\n".join(theme.lua for theme in selected)
        lua += "\nend\nreturn { init = init }\n"
        files = {"main.lua": lua.encode("utf-8")}
        assets = sorted({asset for theme in selected for asset in theme.assets})
        report("download", "Preparing selected themes", 0, max(1, len(assets)))
        for index, name in enumerate(assets):
            report("download", f"Loading {name}", index, len(assets))
            try:
                data = (self.local_folder / name).read_bytes() if self.local_folder else download(self.asset_url(name, self.revision), progress=lambda n, total: report("download", f"{name} — {n:,} / {total:,} bytes" if total else f"{name} — {n:,} bytes", index + (n / total if total else 0), len(assets)))
            except Exception as error:
                raise ValueError(f"Cannot load required image {name}: {error}") from error
            if not data.startswith(b"\x89PNG\r\n\x1a\n"):
                raise ValueError(f"{name} is not a PNG image")
            files[name] = data
            report("download", f"Ready: {name}", index + 1, len(assets))
        metadata = {"app": "Theme Studio for Ethos", "repository": REPOSITORY, "revision": self.revision,
                    "keys": [theme.key for theme in selected], "installed_at": datetime.now(timezone.utc).isoformat(),
                    "sha256": {name: hashlib.sha256(data).hexdigest() for name, data in files.items()}}
        files["updater.json"] = json.dumps(metadata, indent=2).encode()
        return files


def is_radio_root(root: Path) -> bool:
    return root.is_dir() and (root / "radio.bin").is_file() and (root / "models").is_dir()


def detect_radios() -> list[Path]:
    if os.name != "nt":
        return []
    mask = ctypes.windll.kernel32.GetLogicalDrives()
    roots = []
    for index in range(26):
        if mask & (1 << index):
            root = Path(f"{chr(65 + index)}:/")
            # USB storage can report as either a removable or a fixed volume.
            kind = ctypes.windll.kernel32.GetDriveTypeW(str(root))
            if kind in (2, 3) and is_radio_root(root):
                roots.append(root)
    return roots


def remove_install_folder(folder: Path, parent: Path, prefix: str):
    """Only recursively remove the installer's temporary folder on this volume."""
    if folder.is_symlink() or folder.is_junction() or folder.resolve().parent != parent.resolve() or not folder.name.startswith(prefix):
        raise ValueError(f"Refusing to remove an unexpected install folder: {folder}")
    shutil.rmtree(folder)


def package_path(name: str) -> Path:
    parts = name.split("/")
    if not parts or any(not re.fullmatch(r"[A-Za-z0-9_. -]+", part) or part in (".", "..") or part.endswith((".", " "))
                        or part.split(".")[0].upper() in {"CON", "PRN", "AUX", "NUL", *[f"COM{i}" for i in range(1, 10)], *[f"LPT{i}" for i in range(1, 10)]} for part in parts):
        raise ValueError(f"Invalid package filename: {name}")
    return Path(*parts)


def validate_script_folder(folder: str):
    package_path(folder)
    if "/" in folder or "\\" in folder or folder.startswith(".") or folder.casefold() == "themes" or len(folder) > 64:
        raise ValueError("Choose a single script folder name other than Themes")


def unpack_wizard(data: bytes, revision: str, report=lambda *args: None) -> dict[str, bytes]:
    required = {"main.lua", "lib/register_model_wizard.lua", "app/lib/model_wizard.lua", "icon.png", "legacy-icon.png"}
    files = {}
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        members = archive.infolist()
        if len(members) > 256 or sum(item.file_size for item in members) > 32 * 1024 * 1024:
            raise ValueError("Wizard archive exceeds package limits")
        manifest = json.loads(archive.read("ethos_lua_manifest.json"))
        if manifest.get("folder") != WIZARD_FOLDER:
            raise ValueError("Wizard manifest has an unexpected destination")
        seen = set()
        for index, item in enumerate(members):
            package_path(item.filename.rstrip("/"))
            if item.filename.casefold() in seen or (item.external_attr >> 16) & 0o170000 == 0o120000 or item.flag_bits & 1:
                raise ValueError("Wizard archive contains duplicate, encrypted or linked entries")
            seen.add(item.filename.casefold())
            if item.is_dir():
                continue
            if item.filename == "ethos_lua_manifest.json":
                continue
            if not item.filename.startswith(WIZARD_FOLDER + "/"):
                raise ValueError("Wizard archive contains files outside its script folder")
            name = item.filename[len(WIZARD_FOLDER) + 1:]
            package_path(name)
            if name.lower().endswith(".luac"):
                continue  # Compile for the radio's own firmware.
            if name.casefold() == "updater.json":
                raise ValueError("Wizard archive contains reserved installer metadata")
            files[name] = archive.read(item)
            report("verify", f"Checked wizard file: {name}", index + 1, len(members))
        if not required <= files.keys():
            raise ValueError("Wizard archive is missing required Lua files or icons")
        for name in required:
            if name.endswith(".png") and not files[name].startswith(b"\x89PNG\r\n\x1a\n"):
                raise ValueError(f"Wizard icon is not a PNG: {name}")
        files["ethos_lua_manifest.json"] = json.dumps(manifest, indent=2).encode()
        files["updater.json"] = json.dumps({"app": "Theme Studio for Ethos", "repository": WIZARD_REPOSITORY,
            "revision": revision, "version": manifest.get("version", "unknown"),
            "sha256": {name: hashlib.sha256(content).hexdigest() for name, content in files.items()}}, indent=2).encode()
    return files


def wizard_files(report=lambda *args: None) -> dict[str, bytes]:
    report("connect", "Checking Model Wizard on GitHub", 0, 1)
    revision = download(f"https://api.github.com/repos/{WIZARD_REPOSITORY}/commits/main", json_response=True)["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError("GitHub returned an invalid wizard revision")
    report("download", f"Downloading Heli Model Wizard / {revision[:8]}", 0, 1)
    data = download(f"https://api.github.com/repos/{WIZARD_REPOSITORY}/contents/{WIZARD_ARCHIVE}?ref={revision}",
        progress=lambda n, total: report("download", f"Model Wizard — {n:,} bytes", n, total))
    return unpack_wizard(data, revision, report)


def install(root: Path, files: dict[str, bytes], report=lambda *args: None, *, folder="Themes") -> None:
    """Stage and verify, swap in the selection, then delete superseded themes."""
    root = root.resolve(strict=True)
    if not is_radio_root(root):
        raise ValueError("Choose the Ethos storage root containing radio.bin and models. Use USB storage mode.")
    scripts = root / "scripts"
    if folder != "Themes":
        validate_script_folder(folder)
    target = scripts / folder
    # Reject junctions/symlinks so installation remains on the selected storage.
    for destination in (scripts, target):
        if destination.is_symlink() or destination.is_junction():
            raise ValueError(f"Linked destination is not supported: {destination}")
        if destination.exists() and not destination.is_dir():
            raise ValueError(f"Expected a folder: {destination}")
    if "main.lua" not in files or "updater.json" not in files:
        raise ValueError("Incomplete script package")
    for name in files:
        package_path(name)
        if folder == "Themes" and not re.fullmatch(r"[A-Za-z0-9_.-]+\.(lua|png|json)", name):
            raise ValueError(f"Invalid package filename: {name}")
    keys = {theme.key for theme in parse_themes(files["main.lua"].decode())} if folder == "Themes" else set()
    if scripts.exists() and keys:
        for other in scripts.iterdir():
            if other.name.lower() == "themes" or not other.is_dir():
                continue
            entry = other / "main.lua"
            if entry.is_file():
                text = entry.read_text(encoding="utf-8", errors="replace")
                if "registerTheme" in text:
                    try:
                        conflicts = keys & {theme.key for theme in parse_themes(text)}
                    except ValueError:
                        raise ValueError(f"Cannot check theme keys in {entry}. Move that theme script off the radio first.")
                    if conflicts:
                        raise ValueError(f"Duplicate themes in {other.name}: {', '.join(sorted(conflicts))}. Move that folder off the radio first.")
    required = sum(map(len, files.values())) + 2 * 1024 * 1024
    if shutil.disk_usage(root).free < required:
        raise ValueError("Not enough free space on the radio")
    scripts.mkdir(exist_ok=True)
    stage = Path(tempfile.mkdtemp(prefix=".theme-install-", dir=scripts))
    previous = None
    swapped = False
    try:
        report("verify", "Writing and verifying files on radio storage", 0, len(files))
        for index, (name, data) in enumerate(files.items()):
            (stage / name).parent.mkdir(parents=True, exist_ok=True)
            with (stage / name).open("wb") as output:
                output.write(data)
                output.flush()
                os.fsync(output.fileno())
            if (stage / name).read_bytes() != data:
                raise OSError(f"Write verification failed for {name}")
            report("verify", f"Verified: {name}", index + 1, len(files))
        if target.exists():
            report("install", f"Replacing existing {folder} package", 0, 3)
            previous = root / (".theme-replacing-" + uuid.uuid4().hex)
            target.rename(previous)
        try:
            report("install", f"Activating {folder}", 1, 3)
            stage.rename(target)
            swapped = True
        except OSError as error:
            if previous:
                try:
                    previous.rename(target)
                except OSError as rollback:
                    raise OSError(f"Install interrupted. Original package remains at {previous}. Restore it to scripts/{folder}. {rollback}") from error
            raise
        if previous:
            report("install", f"Deleting replaced {folder} files", 2, 3)
            try:
                remove_install_folder(previous, root, ".theme-replacing-")
            except OSError as error:
                raise OSError(f"New themes are installed ({folder}), but old files could not be deleted from {previous}. {error}") from error
        report("install", f"{folder} installed. Eject storage and restart the radio.", 3, 3)
    finally:
        if not swapped and stage.exists():
            remove_install_folder(stage, scripts, ".theme-install-")
