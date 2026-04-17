{ lib, ... }:

# Hardware settings common to all physical hosts in this config.
# Machine-specific overrides (CPU microcode, kernel modules) belong in
# the per-host file (hardware/<hostname>.nix).
{
  # Bluetooth
  hardware.bluetooth = {
    enable = lib.mkDefault true;
    powerOnBoot = lib.mkDefault false;
  };

  # Common kernel parameters
  boot.kernelParams = lib.mkDefault [ "quiet" "splash" ];
}
