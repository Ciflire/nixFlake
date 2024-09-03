{
  description = "Nixos config flake";

  inputs = {

    ags.url = "github:Aylur/ags";

    aquamarine = {
      url = "github:hyprwm/aquamarine";
    };

    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixpkgs-master.url = "github:nixos/nixpkgs/master";

    stylix.url = "github:danth/stylix";
    # stylix.url = "github:ciflire/stylix";
    helix.url = "github:helix-editor/helix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprlock.url = "github:hyprwm/Hyprlock";

    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      # inputs.aquamarine.follows = "aquamarine";
    };

    hyprland-plugins = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hypridle.url = "github:hyprwm/hypridle";

    hyprpaper.url = "github:hyprwm/hyprpaper";

    quickshell.url = "github:outfoxxed/quickshell";

    steam-tui.url = "github:dmadisetti/steam-tui";

    walker.url = "github:abenz1267/walker";

  };

  outputs =
    { self, nixpkgs, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations.default = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
        };
        modules = [
          ./core/configuration.nix
          inputs.home-manager.nixosModules.default
          inputs.stylix.nixosModules.stylix
        ];
      };
    };
}
