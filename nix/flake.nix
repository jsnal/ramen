{
  description = "Ramen environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems
          (system: f nixpkgs.legacyPackages.${system});
    in {
      lib.packages = forAllSystems (pkgs:
        with pkgs; [
          git
          git-lfs
          neovim
          ripgrep
          tmux
        ]
      );

      packages = forAllSystems (pkgs: {
        default = pkgs.buildEnv {
          name = "ramen";
          paths = self.lib.packages.${pkgs.stdenv.hostPlatform.system};
        };
      });
    };
}
