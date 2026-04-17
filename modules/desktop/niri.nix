{ inputs, ... }:

# NixOS-level niri setup: installs the niri package, wires up the
# xdg-desktop-portal-gnome (required for screen sharing / file picker),
# and sets the Wayland session environment.
#
# Home-manager side (compositor settings, keybinds, window rules) lives in
# home/desktop/niri.nix and requires the homeModule imported in mkHome:
#   inputs.niri-flake.homeModules.config
{
  imports = [ inputs.niri-flake.nixosModules.niri ];

  # Polkit agent — required by niri for privilege escalation prompts.
  security.polkit.enable = true;

  # Common Wayland session variables
  environment.sessionVariables = {
    NIXOS_OZONE_WL     = "1";   # hint Electron apps to use Wayland
    MOZ_ENABLE_WAYLAND = "1";   # Firefox Wayland
  };
}
