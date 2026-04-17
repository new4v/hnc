{ inputs, ... }:

{
  imports = [
    inputs.my-modules.homeManagerModules.dev
    inputs.my-modules.homeManagerModules.shell
    ./desktop.nix
    ./editors.nix
    ./config.nix
    ./browsers.nix
  ];

  # username and homeDirectory are set per-user via mkHome in flake.nix
  # Override these in a host-specific home module if needed.
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
