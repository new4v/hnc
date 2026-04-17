{ pkgs, config, ... }:

# tmux — live-editable config symlinked from config/tmux/tmux.conf.
# Edit that file and restart/reload tmux (`prefix + R`); no rebuild needed.
let
  repo = "${config.home.homeDirectory}/hnc";
in
{
  home.packages = [ pkgs.tmux ];

  home.file.".config/tmux/tmux.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${repo}/config/tmux/tmux.conf";
}
