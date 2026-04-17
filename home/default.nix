{ ... }:

{
  imports = [
    ./core.nix          # session vars, XDG, fonts
    ./shell             # ZSH + starship + git + tmux + tools (shell/default.nix)
    ./desktop/niri.nix
    ./desktop/noctila.nix
    ./desktop/waybar.nix
    ./desktop/theme.nix
    ./editors/emacs.nix
    ./editors/helix.nix
    ./editors/vscode.nix
    ./browsers.nix
    ./dev.nix
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
