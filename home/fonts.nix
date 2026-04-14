# home/fonts.nix
#
# Custom fonts — JetBrainsMono Nerd Font for terminal glyph/icon support.
#
# nixpkgs 24.11 ships individual Nerd Fonts as pkgs.nerd-fonts.<kebab-name>.
# JetBrainsMono is chosen because:
#   - It already appears in editors.nix (VS Code) as "JetBrains Mono"
#   - Excellent Nerd Font glyph coverage (powerline, devicons, file-type icons)
#   - Works with the starship glyphs in shell.nix (git branch, nix_shell symbols)
#
# After install the exact font family name is "JetBrainsMono Nerd Font".
# Alacritty is updated in desktop.nix to use this name explicitly.
# The fontconfig alias below also maps the generic "monospace" family to it,
# so any app that requests "monospace" benefits automatically.

{ pkgs, ... }:

{
  home.packages = [
    pkgs.nerd-fonts.jetbrains-mono
  ];

  # Enable home-manager's user-level fontconfig profile management.
  fonts.fontconfig.enable = true;

  # Map the generic "monospace" alias to JetBrainsMono Nerd Font so every
  # terminal and editor that requests the generic family gets the Nerd Font.
  xdg.configFile."fontconfig/fonts.conf".text = ''
    <?xml version="1.0"?>
    <!DOCTYPE fontconfig SYSTEM "fonts.dtd">
    <fontconfig>
      <alias>
        <family>monospace</family>
        <prefer>
          <family>JetBrainsMono Nerd Font</family>
        </prefer>
      </alias>
      <alias>
        <family>Monospace</family>
        <prefer>
          <family>JetBrainsMono Nerd Font</family>
        </prefer>
      </alias>
    </fontconfig>
  '';
}
