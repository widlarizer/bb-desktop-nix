{
  description = "bb desktop app (get-bb/bb) for Linux, kept at the latest release";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      release = builtins.fromJSON (builtins.readFile ./release.json);
      bb-desktop = pkgs.appimageTools.wrapType2 {
        pname = "bb-desktop";
        inherit (release) version;
        src = pkgs.fetchurl { inherit (release) url hash; };
        meta.mainProgram = "bb-desktop";
      };
    in {
      packages.${system} = {
        inherit bb-desktop;
        default = bb-desktop;
      };
    };
}
