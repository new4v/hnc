{ inputs, ... }:

{
  # ── Host variables ──────────────────────────────────────────────
  hostname   = "mythbox";
  username   = "alice";              # change to your username
  system     = "x86_64-linux";
  systemType = "physical";           # physical | vm | live-usb

  # ── Host-specific NixOS module ──────────────────────────────────
  nixosModule = { ... }: {
    imports = [ ./hardware-configuration.nix ];

    # Put host-specific overrides here, e.g.:
    # time.timeZone = "America/New_York";
    # services.xserver.enable = true;
  };
}
