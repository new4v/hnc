{ inputs, ... }:

# Shell environment: ZSH + Starship + Git (from modules repo) plus
# local tmux and additional tools.
{
  imports = [
    inputs.my-modules.homeManagerModules.shell   # ZSH, Starship, Git, delta
    ./tmux.nix
    ./tools.nix
  ];
}
