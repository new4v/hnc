{ config, lib, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./packages.nix
  ];

  # username and homeDirectory are set per-user via mkHome in flake.nix
  # Override these in a host-specific home module if needed.
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
