{ hostMeta, lib, ... }:

{
  programs.git = {
    enable = true;
    userName = lib.mkDefault hostMeta.username;
    userEmail = lib.mkDefault "${hostMeta.username}@${hostMeta.hostname}";
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };
}
