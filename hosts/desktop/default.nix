{ config, pkgs, ... }:

{
  imports = [
    ../disks/btrfs.nix
  ];

  networking.hostName = "desktop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root.initialPassword = "changeme";

  system.stateVersion = "24.11";
}
