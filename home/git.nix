{ config, lib, ... }:

{
  programs.git = {
    enable = true;
    # Override these per-user/host as needed
    userName = lib.mkDefault config.home.username;
    userEmail = lib.mkDefault "${config.home.username}@nixos";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
