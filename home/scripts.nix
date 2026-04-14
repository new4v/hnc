# home/scripts.nix
#
# Puts ~/hnc/config/scripts/ on $PATH so custom scripts are directly callable.
#
# Strategy:
#   1. Create a live symlink ~/.local/bin/scripts → ~/hnc/config/scripts via
#      mkOutOfStoreSymlink (same pattern as config.nix for tmux/tridactyl).
#   2. Add ~/.local/bin/scripts to home.sessionPath.
#
# After `nixos-rebuild switch`, open a new shell and the scripts are available:
#   rebuild, update, gc, sysinfo, ports
#
# Editing any file in config/scripts/ takes effect immediately in the next
# shell invocation — no rebuild needed.

{ config, ... }:

let
  repo = "${config.home.homeDirectory}/hnc";
in
{
  # Put the scripts directory on PATH.
  home.sessionPath = [ "${config.home.homeDirectory}/.local/bin/scripts" ];

  # Live symlink: ~/.local/bin/scripts → ~/hnc/config/scripts
  home.file.".local/bin/scripts".source =
    config.lib.file.mkOutOfStoreSymlink "${repo}/config/scripts";
}
