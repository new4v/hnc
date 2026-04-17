{ pkgs, ... }:

# GTK / Qt / cursor theme.
# Keeping GTK and Qt in sync avoids mismatched widget rendering.
{
  # ── GTK ─────────────────────────────────────────────────────────────────────
  gtk = {
    enable = true;
    theme = {
      name    = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };
    iconTheme = {
      name    = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name    = "Adwaita";
      size    = 24;
      package = pkgs.adwaita-icon-theme;
    };
    gtk3.extraConfig.gtk-application-prefer-dark-theme = true;
    gtk4.extraConfig.gtk-application-prefer-dark-theme = true;
  };

  # ── Qt ───────────────────────────────────────────────────────────────────────
  qt = {
    enable = true;
    platformTheme.name = "gtk";
    style.name = "adwaita-dark";
  };

  # ── Cursor for Wayland/X11 ───────────────────────────────────────────────────
  home.pointerCursor = {
    name    = "Adwaita";
    size    = 24;
    package = pkgs.adwaita-icon-theme;
    gtk.enable = true;
  };
}
