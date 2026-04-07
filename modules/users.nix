{ hostMeta, pkgs, ... }:

{
  users.users.${hostMeta.username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.bash;
    # Replace with hashedPassword or remove for key-only auth
    initialPassword = "changeme";
  };
}
