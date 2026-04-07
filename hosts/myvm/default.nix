{ inputs, ... }:

{
  # ── Host variables ──────────────────────────────────────────────
  hostname   = "myvm";
  username   = "alice";              # change to your username
  system     = "x86_64-linux";
  systemType = "vm";                 # physical | vm | live-usb

  # ── Host-specific NixOS module ──────────────────────────────────
  nixosModule = { ... }: {
    imports = [ ./hardware-configuration.nix ];

    # Put host-specific overrides here, e.g.:
    # services.openssh.enable = true;
  };
}
