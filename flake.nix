{
  description = "Nixos config flake";

  inputs = {

    aquamarine.url = "github:hyprwm/aquamarine";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    stylix.url = "github:danth/stylix";

    helix.url = "github:helix-editor/helix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # inputs.aquamarine.follows = "aquamarine";
    };

    hyprlock.url = "github:hyprwm/Hyprlock";

    hypridle.url = "github:hyprwm/hypridle";

    hyprpanel.url = "github:Jas-SinghFSU/HyprPanel";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    hyprsunset.url = "github:hyprwm/hyprsunset";

    hyprsysteminfo.url = "github:hyprwm/hyprsysteminfo";

    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    walker.url = "github:abenz1267/walker";

  };

  outputs =
    {
      self,
      nixpkgs,
      lix-module,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${pkgs.system};
    in
    {

      overlays = {
        hyprpanel = inputs.hyprpanel.packages.${pkgs.system}.default;
      };
      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./core/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
          lix-module.nixosModules.default
        ];
      };
    };
}
