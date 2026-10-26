"""Install workspace themes before invoking the Ethos simulator commands."""

import json
import os
from pathlib import Path
import shutil


def install_themes():
    workspace = Path(__file__).resolve().parents[2]
    settings = json.loads((workspace / ".vscode/settings.json").read_text(encoding="utf-8"))
    folder = settings.get("ethos.simulatorsFolder", "simulators")
    folder = folder.replace("${workspaceFolder}", str(workspace)).replace("$workspaceFolder", str(workspace))
    folder = os.path.expandvars(folder)
    radio = "{}_{}@{}".format(
        settings["ethos.board"], settings["ethos.protocol"], settings["ethos.release"]
    )
    destination = workspace / folder / radio / "scripts" / "Themes"
    source = workspace / "Themes"
    destination.mkdir(parents=True, exist_ok=True)
    for asset in source.iterdir():
        # Ethos must compile its own bytecode for the selected firmware.
        if asset.is_file() and asset.suffix.lower() in {".lua", ".png"}:
            shutil.copy2(asset, destination / asset.name)
    (destination / "main.luac").unlink(missing_ok=True)
    print(f"Installed themes in {destination}")


if __name__ == "__main__":
    install_themes()
