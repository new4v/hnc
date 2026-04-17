{ pkgs, config, ... }:

# Emacs with pure-GTK backend (Wayland GUI + TUI -nw).
# Config lives in config/emacs/init.el — live-editable, no rebuild needed.
let
  repo = "${config.home.homeDirectory}/hnc";
in
{
  programs.emacs = {
    enable  = true;
    package = pkgs.emacs-pgtk;
    extraPackages = epkgs: [ epkgs.which-key ];

    # Thin loader — delegates to the live file in the repo.
    extraConfig = ''
      (load (expand-file-name "${repo}/config/emacs/init.el") nil :nomessage)
    '';
  };
}
