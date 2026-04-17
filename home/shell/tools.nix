{ inputs, ... }:

# CLI quality-of-life tools: fzf, bat, zoxide, eza, ripgrep, fd, jq, direnv.
# All provided by the modules repo; add local extras below.
{
  imports = [
    inputs.my-modules.homeManagerModules.dev   # direnv, fzf, bat, zoxide, fd, rg, jq, eza
  ];

  # Additional tools not in the modules repo:
  # home.packages = with pkgs; [ ... ];
}
