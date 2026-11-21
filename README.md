# bb-desktop-nix

The [bb](https://github.com/get-bb/bb) desktop app for Linux as a Nix flake. It wraps the official AppImage from bb's GitHub releases.

```sh
nix run github:<owner>/bb-desktop-nix
```

Every three hours, a GitHub Actions job checks which version bb's `desktop-latest` release names. When it changes, the job updates `release.json` to that version's AppImage and its sha512, builds it, and commits. Run `./update.sh` to do the same by hand.

x86_64-linux only, because bb publishes only that AppImage for Linux.
