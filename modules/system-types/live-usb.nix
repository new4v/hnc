{ lib, pkgs, ... }:

{
  # SSH access for the live environment
  services.openssh.enable = lib.mkDefault true;
  services.openssh.settings.PermitRootLogin = lib.mkDefault "yes";

  # Helpful packages for installation
  environment.systemPackages = with pkgs; [
    gparted
    nixos-install-tools
  ];

  # Copy root filesystem to RAM for better performance
  boot.kernelParams = [ "copytoram" ];
}
