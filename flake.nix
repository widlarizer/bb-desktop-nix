{
  description = "bb desktop app (get-bb/bb) for Linux, kept at the latest release";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      release = builtins.fromJSON (builtins.readFile ./release.json);
      pname = "bb-desktop";
      inherit (release) version;
      src = pkgs.fetchurl { inherit (release) url hash; };
      contents = pkgs.appimageTools.extract { inherit pname version src; };
      bb-desktop = pkgs.appimageTools.wrapType2 {
        inherit pname version src;
        extraInstallCommands = ''
          install -Dm644 ${contents}/usr/share/icons/hicolor/1024x1024/apps/bb.png \
            $out/share/icons/hicolor/1024x1024/apps/bb-desktop.png
          install -Dm644 ${./bb-desktop.desktop} $out/share/applications/bb-desktop.desktop
          substituteInPlace $out/share/applications/bb-desktop.desktop \
            --replace-fail 'Exec=nix run github:widlarizer/bb-desktop-nix -- %U' 'Exec=bb-desktop %U'
        '';
        meta.mainProgram = "bb-desktop";
      };
    in {
      packages.${system} = {
        inherit bb-desktop;
        default = bb-desktop;
      };
    };
}
