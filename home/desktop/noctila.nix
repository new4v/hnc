{ ... }:

# Noctalia desktop shell (top bar, notifications, app launcher) and
# Alacritty terminal emulator.
# Requires inputs.noctalia.homeModules.default imported in mkHome (flake.nix).
{
  # ── Noctalia desktop shell ────────────────────────────────────────────────────
  programs.noctalia.enable = true;

  # ── Alacritty terminal ────────────────────────────────────────────────────────
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity         = 0.95;
        padding         = { x = 8; y = 8; };
        dynamic_padding = true;
        decorations     = "none";
      };
      font = {
        normal  = { family = "monospace"; style = "Regular"; };
        bold    = { family = "monospace"; style = "Bold"; };
        italic  = { family = "monospace"; style = "Italic"; };
        size    = 12.0;
        offset  = { x = 0; y = 1; };
      };
      cursor = {
        style            = { shape = "Beam"; blinking = "On"; };
        blink_interval   = 600;
        unfocused_hollow = true;
      };
      shell.program     = "zsh";
      scrolling.history = 10000;
    };
  };
}
