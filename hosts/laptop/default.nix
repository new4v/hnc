{ config, pkgs, ... }:

{
  imports = [
    ../disks/ext4.nix
  ];

  networking.hostName = "laptop";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.root.initialPassword = "changeme";

  system.stateVersion = "24.11";
}
