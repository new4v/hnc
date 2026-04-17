{ config, lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    ./common.nix
    ./disko/ext4.nix   # swap to btrfs.nix or zfs.nix to change the filesystem
  ];

  networking.hostName = "thinkpad-e16";

  boot.initrd.availableKernelModules = [ ];
  boot.kernelModules = [ ];

  # ThinkPad E16-specific overrides:
  #   hardware.cpu.intel.updateMicrocode = true;   # if Intel CPU
  #   hardware.cpu.amd.updateMicrocode   = true;   # if AMD CPU
  #   imports = [ nixos-hardware.nixosModules.lenovo-thinkpad-e16-amd ];
}
