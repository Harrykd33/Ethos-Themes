"""Read-only owner-published GitHub catalog and script package downloads."""
from dataclasses import dataclass
import hashlib
import io
import json
from pathlib import Path
import re
from urllib.error import HTTPError
from urllib.parse import quote
import zipfile

from core import download, package_path, validate_script_folder, REPOSITORY, WIZARD_REPOSITORY, WIZARD_FOLDER, wizard_files


@dataclass(frozen=True)
class ScriptPackage:
    name: str
    repository: str
    source: str
    folder: str
    branch: str

    @property
    def identity(self):
        return f"{self.repository.casefold()}:{self.source.casefold()}"

    @property
    def url(self):
        return f"https://github.com/{self.repository}"


WIZARD = ScriptPackage("Heli Model Wizard", WIZARD_REPOSITORY, WIZARD_FOLDER, WIZARD_FOLDER, "main")


def repository_name(value):
    value = value.strip().rstrip("/")
    value = re.sub(r"^https://github\.com/", "", value, flags=re.I)
    if value.endswith(".git"):
        value = value[:-4]
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", value):
        raise ValueError("Enter a public GitHub repository URL or owner/repository")
    return value


def validate(package):
    if not all(isinstance(value, str) for value in (package.name, package.repository, package.source, package.folder, package.branch)):
        raise ValueError("Package definition fields must be text")
    if repository_name(package.repository) != package.repository:
        raise ValueError("Catalog repositories must use owner/repository format")
    validate_script_folder(package.folder)
    if package.source:
        package_path(package.source)
    if not package.name.strip() or len(package.name) > 80 or not package.branch.strip():
        raise ValueError("A package needs a name (up to 80 characters) and a branch")
    return package


def parse_catalog(data):
    document = json.loads(data) if isinstance(data, (str, bytes)) else data
    if not isinstance(document, dict) or document.get("schema_version") != 1 or not isinstance(document.get("packages"), list):
        raise ValueError("Unsupported script catalog format")
    if len(document["packages"]) > 100:
        raise ValueError("Script catalog exceeds 100 packages")
    packages = []
    for entry in document["packages"]:
        try:
            package = validate(ScriptPackage(**entry))
        except (TypeError, AttributeError) as error:
            raise ValueError("Invalid script package definition") from error
        if any(p.identity == package.identity or p.folder.casefold() == package.folder.casefold() for p in packages):
            raise ValueError("Script catalog has duplicate repositories or destination folders")
        packages.append(package)
    return packages


def load_packages(path):
    return parse_catalog(Path(path).read_bytes())


def remote_packages(report=lambda *args: None):
    report("connect", "Checking KevinD RC's published script catalog", 0, 1)
    revision = download(f"https://api.github.com/repos/{REPOSITORY}/commits/main", json_response=True)["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError("GitHub returned an invalid catalog revision")
    try:
        data = download(f"https://api.github.com/repos/{REPOSITORY}/contents/script-packages.json?ref={revision}")
    except ValueError as error:
        if isinstance(error.__cause__, HTTPError) and error.__cause__.code == 404:
            raise ValueError("The owner must publish script-packages.json to Ethos-Themes/main. The bundled script list remains available.") from error
        raise
    report("verify", "Checking the published script package list", 1, 1)
    return parse_catalog(data)


def discover_package(repository, source="", folder="", name="", branch="", report=lambda *args: None):
    repository = repository_name(repository)
    report("connect", f"Checking {repository}", 0, 1)
    metadata = download(f"https://api.github.com/repos/{repository}", json_response=True)
    branch = branch.strip() or metadata["default_branch"]
    revision = download(f"https://api.github.com/repos/{repository}/commits/{quote(branch, safe='')}", json_response=True)["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError("GitHub returned an invalid package revision")
    root_requested = source.strip() == "."
    source = source.strip().strip("/")
    source = "" if source == "." else source
    if not source and not root_requested:
        try:
            raw = download(f"https://api.github.com/repos/{repository}/contents/ethos_lua_manifest.json?ref={revision}")
            manifest = json.loads(raw)
            source = manifest.get("folder", "")
            name = name.strip() or manifest.get("name", "")
        except ValueError as error:
            if isinstance(error.__cause__, HTTPError) and error.__cause__.code == 404:
                pass  # A manifest is optional when main.lua is at the repository root.
            else:
                raise
    package = validate(ScriptPackage(name.strip() or repository.split("/")[1], repository, source,
                                    folder.strip() or (source.split("/")[-1] if source else repository.split("/")[1]), branch))
    entry = f"{source}/main.lua" if source else "main.lua"
    report("verify", f"Checking {entry}", 0, 1)
    try:
        download(f"https://api.github.com/repos/{repository}/contents/{quote(entry, safe='/')}?ref={revision}")
    except ValueError as error:
        raise ValueError("Cannot find main.lua. Enter the folder containing the Ethos script, or use . for the repository root.") from error
    return package


def unpack_source(data, package, revision, report=lambda *args: None):
    validate(package)
    files = {}
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        members = archive.infolist()
        if not members or len(members) > 10000 or sum(m.file_size for m in members) > 64 * 1024 * 1024:
            raise ValueError("Repository archive exceeds the 64 MB unpacked limit")
        top = members[0].filename.split("/")[0]
        prefix = top + "/" + (package.source + "/" if package.source else "")
        seen = set()
        for index, member in enumerate(members):
            segments = member.filename.rstrip("/").split("/")
            if any(part in ("", ".", "..") for part in segments) or "\\" in member.filename or not member.filename.startswith(top + "/"):
                raise ValueError("Invalid repository archive path")
            if not member.filename.startswith(prefix) or member.is_dir():
                continue
            relative = member.filename[len(prefix):]
            package_path(relative)
            if relative.casefold() in seen or (member.external_attr >> 16) & 0o170000 == 0o120000 or member.flag_bits & 1:
                raise ValueError("Script archive contains duplicate, encrypted or linked files")
            seen.add(relative.casefold())
            if relative.lower().endswith(".luac") or relative.casefold() == "updater.json" or any(p in (".git", ".github", "__pycache__") for p in relative.split("/")):
                continue
            files[relative] = archive.read(member)
            report("verify", f"Checked {package.name}: {relative}", index + 1, len(members))
    if "main.lua" not in files:
        raise ValueError(f"No main.lua in script folder: {package.source or '.'}")
    files["updater.json"] = json.dumps({"repository": package.repository, "revision": revision,
        "source": package.source, "sha256": {n: hashlib.sha256(d).hexdigest() for n, d in files.items()}}, indent=2).encode()
    return files


def package_files(package, report=lambda *args: None):
    validate(package)
    if package == WIZARD:
        return wizard_files(report)
    report("connect", f"Checking latest {package.name}", 0, 1)
    revision = download(f"https://api.github.com/repos/{package.repository}/commits/{quote(package.branch, safe='')}", json_response=True)["sha"]
    if not re.fullmatch(r"[0-9a-f]{40}", revision):
        raise ValueError("GitHub returned an invalid package revision")
    report("download", f"Downloading {package.name} / {revision[:8]}", 0, 1)
    data = download(f"https://api.github.com/repos/{package.repository}/zipball/{revision}",
                    progress=lambda n, total: report("download", f"{package.name} — {n:,} bytes", n, total))
    return unpack_source(data, package, revision, report)
