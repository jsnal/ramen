# ramen

My configuration for Linux and Unix-like systems.

## Dependencies

- [tmux](http://tmux.sourceforge.net/) 2.3 or later
- [neovim](https://neovim.io/) 0.11 or later
- recent [bash](https://www.gnu.org/software/bash/)

## Installation

```
git clone https://github.com/jsnal/ramen
cd ramen
./install.sh
```

## Nix

Nix is only used to install packages at the moment and is not necassary if the
required packages are already available.

```
sh <(curl -L https://nixos.org/nix/install) --daemon
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
cd nix
nix profile add .
```

Or the base flake can be layered:

```nix
{
  inputs = {
    ramen.url = "path:./nix";
    nixpkgs.follows = "ramen/nixpkgs";
  };

  outputs = { self, nixpkgs, ramen }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" ];
      forAllSystems = f:
        nixpkgs.lib.genAttrs systems
          (system: f nixpkgs.legacyPackages.${system});
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.buildEnv {
          name = "ramen-custom";
          paths =
            ramen.lib.packages.${pkgs.stdenv.hostPlatform.system}
            ++ (with pkgs; [ # Packages ]);
        };
      });
    };
}

```
