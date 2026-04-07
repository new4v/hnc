{ ... }:

{
  imports = [ ./hardware-configuration.nix ];

  networking.hostName = "myvm";

  # Host-specific overrides go here, e.g.:
  # services.openssh.enable = true;
}
