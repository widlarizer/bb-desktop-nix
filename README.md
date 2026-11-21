# bb-desktop-nix

The [bb](https://github.com/get-bb/bb) desktop app for Linux as a Nix flake. It wraps the official AppImage from bb's GitHub releases.

```sh
nix run github:widlarizer/bb-desktop-nix
```

## App menu launcher

To start it from your app menu, always at the latest release, with no terminal:

```sh
curl -fsSL --create-dirs -o ~/.local/share/applications/bb-desktop.desktop \
  https://raw.githubusercontent.com/widlarizer/bb-desktop-nix/main/bb-desktop.desktop
curl -fsSL --create-dirs -o ~/.local/share/icons/hicolor/1024x1024/apps/bb-desktop.png \
  https://raw.githubusercontent.com/widlarizer/bb-desktop-nix/main/bb-desktop.png
```

The first launch after a new bb release shows nothing while Nix downloads the AppImage (about 190 MB).

If you install the package instead (`nix profile install github:widlarizer/bb-desktop-nix`), it brings its own menu entry, but it stays on the installed version until you run `nix profile upgrade`.

## Updates

Every three hours, a GitHub Actions job checks which version bb's `desktop-latest` release names. When it changes, the job updates `release.json` to that version's AppImage and its sha512, builds it, and commits. It also publishes a GitHub release `v<version>`, so `nix run github:widlarizer/bb-desktop-nix/v<version>` runs a fixed version. `./update.sh` does the `release.json` update by hand.

x86_64-linux only, because bb publishes only that AppImage for Linux.
