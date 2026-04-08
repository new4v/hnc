{ config, pkgs, ... }:

{
  imports = [
    ../disks/zfs.nix
  ];

  networking.hostName = "server";

  # ZFS requires a unique 8-hex-digit hostId per machine
  networking.hostId = "a1b2c3d4";

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.supportedFilesystems = [ "zfs" ];

  users.users.root.initialPassword = "changeme";

  system.stateVersion = "24.11";
}
