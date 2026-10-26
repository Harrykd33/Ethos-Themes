"""Prepare the owner's catalog locally. Publishing requires GitHub write access."""
import argparse
from dataclasses import asdict
import json
from pathlib import Path

from packages import discover_package, load_packages, parse_catalog


def main():
    parser = argparse.ArgumentParser(description="Add a verified script to KevinD RC's catalog, then commit and push it with your GitHub account.")
    parser.add_argument("repository", help="Public GitHub URL or owner/repository")
    parser.add_argument("--source", default="", help="Repository script folder; omit to use the manifest, or use . for root")
    parser.add_argument("--folder", default="", help="Radio folder under scripts/")
    parser.add_argument("--name", default="", help="Display name")
    parser.add_argument("--branch", default="", help="Omit to use the default GitHub branch")
    args = parser.parse_args()
    path = Path(__file__).resolve().parents[1] / "script-packages.json"
    packages = load_packages(path)
    package = discover_package(**vars(args))
    document = {"schema_version": 1, "packages": [asdict(p) for p in packages + [package]]}
    parse_catalog(document)
    temporary = path.with_suffix(".json.tmp")
    temporary.write_text(json.dumps(document, indent=2) + "\n", encoding="utf-8")
    temporary.replace(path)
    print(f"Added {package.name} to {path}. Commit and push this file to publish it. No app rebuild is needed.")


if __name__ == "__main__":
    main()
