# Theme Studio for Ethos for Windows

A portable Windows app for installing selected themes from
[Harrykd33/Ethos-Themes](https://github.com/Harrykd33/Ethos-Themes) onto Ethos 26.x radios.

## Use

1. Open `dist/ThemeStudioForEthos.exe`. Python is not required for the built app.
2. Connect your radio over USB and select its **storage / SD card** mode.
3. Select the detected storage drive, or browse to its root. It must contain
   `radio.bin` and `models/`. Multiple volumes may appear; choose Ethos user storage.
4. Choose themes. Click a palette swatch to preview it without changing selection.
   Both Dashboard and Model menu previews recolor immediately using the selected
   Ethos palette. The preview approximates radio rendering and preserves brand artwork.
   The **Dark**, **Light** and **All Themes** radio selectors beside **Themes**
   filter the alphabetically sorted list. Filtering preserves checkbox selections,
   including selections currently hidden by a filter. Use **Clear** to start fresh.
   Explicit `darkMode` settings determine category, with background brightness as
   a fallback when the theme does not specify one.
5. Click **Install selected themes**, review the destination and selected names,
   then confirm. The transfer panel shows download, file verification and installation.
6. Eject the drive in Windows, disconnect, restart the radio, and select your theme
   under **System > General > Theme**.

### Optional Heli Model Wizard

Check **Heli Model Wizard** in the **Script Packages** column to install the
standalone package from [Ethos-RF-Model-Wizard](https://github.com/Harrykd33/Ethos-RF-Model-Wizard).
Use **Clear**, then check only the Wizard to install it without changing themes.
**Select all** selects themes only; the Wizard is always opt-in.

The app downloads `rotorflight-model-wizard-standalone-en.zip` from public `main`,
pinned to one commit, validates its manifest and required files, and installs into
`scripts/rotorflight-model-wizard`. Internet access is required for the Wizard;
it is not bundled with the studio. Updates replace that folder, remove stale
compiled Lua and obsolete package files, and retain no backup. An unchecked
Wizard option leaves any existing Wizard installation alone.

After ejecting and restarting, Ethos 26.2 users can open **Model > Model select >
+ > Create model > Heli Wizard**. Older firmware uses **System > Heli Wizard**.
Before using the Wizard, turn OFF **System > Sticks > First four channels fixed**.
An RF Suite registration at `scripts/rfsuite/lib/register_model_wizard.lua` takes
precedence over the standalone Wizard; the app reports this before installing.

When both package types are selected, all downloads finish before installation.
Each folder is activated separately. If a later package fails, the error reports
which packages were already installed.

### Owner-controlled script catalog

The install area has separate **Themes** and **Script Packages** columns. Users
can select and install published packages; the app has no add/remove repository
controls, no owner password embedded in the executable, and no local package-list
override. It reads `script-packages.json` only from `Harrykd33/Ethos-Themes` on
GitHub. Publishing changes requires write access to that repository. Keep that
write access limited to your account if you should be the only publisher.

To add a public script without rebuilding the app:

1. Edit the repository-root `script-packages.json`, or prepare an entry with:

   ```powershell
   py updater/catalog_admin.py https://github.com/owner/repository --source scripts/my-script --folder my-script --name "My Script"
   ```

2. Commit and push `script-packages.json` to public `main` in `Harrykd33/Ethos-Themes`.
3. Users click **Refresh GitHub**, or reopen the app, to get your published list.

The helper verifies `main.lua` on GitHub before writing a local catalog entry.
Omit `--source` to read the package folder from `ethos_lua_manifest.json`, or use
`--source .` for a script at the repository root. Omit `--branch` to use the
repository's default branch. Each entry specifies `name`, `repository`
(`owner/repo`), `source` (folder inside that repo, or an empty string for root),
`folder` (destination directly under the radio's `scripts/`) and `branch`.
Each script needs its own destination folder and a `main.lua` entry point.

Generic packages download a commit-pinned repository ZIP and install only the
configured source folder. Nested files are preserved; stale `.luac` files are
excluded. Downloads are limited to 16 MB, and repository archives to 64 MB unpacked.
The bundled catalog is used initially; a failed or invalid GitHub refresh keeps
the current list. Removing an entry from the catalog does not uninstall radio files.

The first public release needs to include `script-packages.json` in GitHub's
public `main` branch. The app cannot fetch unpublished local catalog changes.

The app writes only the selected Lua registrations and their PNG assets into
`scripts/Themes/`. This replaces that folder as a package, so deselected themes in
that folder, obsolete images and compiled Lua are deleted after the new package
is activated. No backup is saved on the radio. Other scripts, models and radio
settings are left alone. Never disconnect during transfer.

The app stages and reads back all new files before replacing the active folder.
If activation fails, it attempts to restore the original folder. If USB storage
disappears during the final swap, the error identifies any temporary folder
requiring recovery or deletion. A successful installation removes the temporary
old package. Historical `theme-backups` folders made by older versions are not
changed by this update.

## GitHub and offline use

The app checks both public theme and script catalogs on startup and on
**Refresh GitHub**. Each check runs even if the other catalog fails. It pins every
download to one commit so scripts and images use the same revision. No GitHub
account or token is required. If GitHub is unavailable, the included themes remain
available and are clearly marked **BUNDLED**. A failed check never switches a live
catalog silently to a different source.

The themes repository is public and live theme loading has been verified.
Push `Themes/main.lua` plus its PNG files to `main` to publish theme updates.
The bundled catalog remains available when offline. Each theme must be a self-contained
`system.registerTheme({...})` call with a literal `key`, literal `name`, and simple
PNG filenames passed to `lcd.loadBitmap`. Shared Lua variables/helpers outside
the registration blocks are not supported. The app doesn't execute downloaded Lua
on Windows. On the radio, installed Lua runs normally at startup.

## Build / develop

Use 64-bit Python 3.14 on Windows:

```powershell
py -m pip install -r updater/requirements.txt
py updater/app.py
powershell -ExecutionPolicy Bypass -File updater/build.ps1
```

The build script runs the installer tests and generates the portable executable
in `dist/`. Build output is ignored by Git. Publish the executable manually as a
GitHub Release asset if you want others to download it. This app does not update
its own executable; **Check GitHub** updates the theme catalog.

The executable is unsigned. No firmware compatibility detection or firmware
flashing is performed; confirm Ethos 26.x on your radio before installation.

## Validation

```powershell
py -m unittest discover -s updater/tests -v
```

Tests cover selective packaging, pinned GitHub revisions, source parsing, invalid
paths, USB root validation, obsolete file deletion, unrelated data preservation, staging failure,
activation rollback and duplicate theme keys in other script folders.
