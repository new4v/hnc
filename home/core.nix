{ pkgs, ... }:

# Shared home-manager baseline applied to every user on every host.
# Put things here that belong to the user environment regardless of
# which desktop or shell is active.
{
  # ── Session variables ────────────────────────────────────────────────────────
  home.sessionVariables = {
    BROWSER = "firefox";
  };

  # ── XDG base directories ─────────────────────────────────────────────────────
  xdg.enable = true;

  # ── Fonts ────────────────────────────────────────────────────────────────────
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    noto-fonts
    noto-fonts-emoji
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
  ];
}
