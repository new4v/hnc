{ pkgs, config, ... }:

# Helix modal editor.
# Config is managed as live files in config/helix/ (edit without rebuild).
# The Nix module installs the binary and sets $EDITOR; TOML files are
# symlinked from the repo so changes take effect immediately.
let
  repo = "${config.home.homeDirectory}/hnc";
in
{
  programs.helix = {
    enable        = true;
    defaultEditor = true;   # sets $EDITOR and $VISUAL
  };

  # Live-editable config — symlinked to config/helix/ in the repo
  home.file.".config/helix/config.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${repo}/config/helix/config.toml";
  home.file.".config/helix/languages.toml".source =
    config.lib.file.mkOutOfStoreSymlink "${repo}/config/helix/languages.toml";

  # LSP and formatter helpers referenced in config/helix/languages.toml
  home.packages = with pkgs; [
    nil              # Nix language server
    nixfmt-rfc-style # Nix formatter (nixfmt)
  ];
}
