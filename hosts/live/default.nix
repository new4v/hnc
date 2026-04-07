{ inputs, ... }:

{
  # ── Host variables ──────────────────────────────────────────────
  hostname   = "nixos-live";
  username   = "nixos";
  system     = "x86_64-linux";
  systemType = "live-usb";           # physical | vm | live-usb

  # ── Host-specific NixOS module ──────────────────────────────────
  nixosModule = { modulesPath, ... }: {
    imports = [
      (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
    ];

    # Put live-USB-specific overrides here
  };
}
