{ lib, modulesPath, ... }:

{
  # Bootloader — GRUB is more portable in VMs
  boot.loader.grub.enable = lib.mkDefault true;
  boot.loader.grub.device = lib.mkDefault "/dev/vda";

  # Guest integration
  services.qemuGuest.enable = lib.mkDefault true;
  services.spice-vdagentd.enable = lib.mkDefault true;

  # No firmware blobs needed
  hardware.enableRedistributableFirmware = lib.mkDefault false;
}
