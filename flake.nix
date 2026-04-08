{
  description = "NixOS configuration with home-manager and disko";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, nixos-hardware, disko, ... }:
    let
      lib = nixpkgs.lib;

      mkHost = { system, modules }: lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs nixos-hardware disko; };
        modules = modules;
      };

      mkHome = username: hmConfigPath: [
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.${username} = {
              imports = [ hmConfigPath ];
              home.username = username;
              home.homeDirectory = "/home/${username}";
            };
          };
        }
      ];
    in
    {
      nixosConfigurations = {
        # ── Physical machine ────────────────────────────────────
        mythbox = mkHost {
          system = "x86_64-linux";
          modules = [
            ./hosts/mythbox
            ./modules/core.nix
            (import ./modules/users.nix "alice")
            ./profiles/physical.nix
          ] ++ mkHome "alice" ./home;
        };

        # ── Virtual machine ─────────────────────────────────────
        myvm = mkHost {
          system = "x86_64-linux";
          modules = [
            ./hosts/myvm
            ./modules/core.nix
            (import ./modules/users.nix "alice")
            ./profiles/vm.nix
          ] ++ mkHome "alice" ./home;
        };

        # ── Live USB ────────────────────────────────────────────
        live = mkHost {
          system = "x86_64-linux";
          modules = [
            ./hosts/live
            ./modules/core.nix
            (import ./modules/users.nix "nixos")
            ./profiles/live-usb.nix
          ] ++ mkHome "nixos" ./home;
        };

        # ── Disko configurations ────────────────────────────────
        server = mkHost {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/server
          ];
        };

        desktop = mkHost {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/desktop
          ];
        };

        laptop = mkHost {
          system = "x86_64-linux";
          modules = [
            disko.nixosModules.disko
            ./hosts/laptop
          ];
        };
      };

      # Reusable NixOS modules
      nixosModules = {
        physical = import ./profiles/physical.nix;
        vm = import ./profiles/vm.nix;
        live-usb = import ./profiles/live-usb.nix;
        core = import ./modules/core.nix;
      };
    };
}
