{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = { url = "github:nix-community/home-manager";
                     inputs.nixpkgs.follows = "nixpkgs"; };

    xremap-flake.url = "github:xremap/nix-flake";

    hyprland.url = "github:hyprwm/Hyprland";

    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };

    hycov = {
      url = "github:DreamMaoMao/hycov";
      inputs.hyprland.follows = "hyprland";
    };

  };

  outputs = { self, nixpkgs, home-manager, hyprland, ... } @ inputs :
    let

      system = "x86_64-linux";

      pkgs = nixpkgs.legacyPackages.${system};

    in {
      homeConfigurations."matyas" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;


        modules = [
          hyprland.homeManagerModules.default
          { wayland.windowManager.hyprland.enable = true; } 
          ./home.nix
        ];

        extraSpecialArgs = { inherit inputs; };
        
      };
    };
}
