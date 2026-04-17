{ inputs, pkgs, ... }:

# Development tools: git config, direnv, and language-specific toolchains.
# General CLI quality-of-life tools (fzf, bat, zoxide) live in shell/tools.nix.
{
  imports = [
    # Provides: direnv + nix-direnv, fzf, bat, zoxide, fd, ripgrep, jq, eza
    inputs.my-modules.homeManagerModules.dev
  ];

  # ── Language toolchains ───────────────────────────────────────────────────────
  # Add language-specific packages here as needed.
  home.packages = with pkgs; [
    # go rustup cargo python3 nodejs
  ];
}
