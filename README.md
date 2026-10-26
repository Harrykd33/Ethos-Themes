# Ethos Themes
Themes For Ethos system

## FrSky simulator

In VS Code, open Run and Debug and select **FrSky Simulator: Start / Restart**,
then press F5. The Ethos extension opens the simulator inside VS Code.
The workspace defaults to X18RS / FCC on the nightly26 release. Use
**FrSky Simulator: Select Radio** to change the radio or release, or
**FrSky Simulator: Open Controls** to show the transmitter controls.

The launch configuration is saved in `.vscode/`. Simulator models, radio
settings, and files persist in `simulators/<board>_<protocol>@<release>/`
across simulator restarts and VS Code sessions. This local state is ignored
by Git. Each radio and release has its own state directory.
