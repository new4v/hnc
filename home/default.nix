{ hostMeta, lib, ... }:

{
  imports = [
    ./shell.nix
    ./git.nix
    ./packages.nix
  ];

  home.username = hostMeta.username;
  home.homeDirectory = "/home/${hostMeta.username}";
  home.stateVersion = "24.11";

  programs.home-manager.enable = true;
}
