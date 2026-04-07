{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "mythbox";

  # Host-specific overrides go here, e.g.:
  # time.timeZone = "America/New_York";
  # services.xserver.enable = true;
}
