{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      # Import all host definitions
      hosts = import ./hosts { inherit inputs; };

      # Helper: build a nixosConfiguration from a host definition
      mkHost = name: hostCfg: nixpkgs.lib.nixosSystem {
        system = hostCfg.system;
        specialArgs = {
          inherit inputs;
          hostMeta = hostCfg;
        };
        modules = [
          ./modules/core.nix
          ./modules/users.nix
          ./modules/system-types

          # Host-specific config (hardware-configuration, overrides)
          hostCfg.nixosModule

          # Home-manager as NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              hostMeta = hostCfg;
            };
            home-manager.users.${hostCfg.username} = import ./home;
          }
        ];
      };
    in
    {
      nixosConfigurations = builtins.mapAttrs mkHost hosts;
    };
}
