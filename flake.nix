{
  description = "ruwbine-dev's NixOS workstation config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.ruwbine = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          # Main NixOS config
          ./configuration.nix

          # Home Manager user config
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.ruwbine = import ./home.nix;
          }
        ];
      };
    };
}

