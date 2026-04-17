{ pkgs, ... }:

# VS Code and Cursor (AI-powered VS Code fork).
# Settings are declarative; extensions are managed via nixpkgs.
{
  programs.vscode = {
    enable = true;
    userSettings = {
      "editor.fontSize"                        = 14;
      "editor.fontFamily"                      = "'JetBrains Mono', 'Fira Code', monospace";
      "editor.fontLigatures"                   = true;
      "editor.formatOnSave"                    = true;
      "editor.minimap.enabled"                 = false;
      "editor.inlineSuggest.enabled"           = true;
      "editor.bracketPairColorization.enabled" = true;
      "editor.guides.bracketPairs"             = true;
      "editor.renderWhitespace"                = "boundary";
      "workbench.colorTheme"                   = "Default Dark+";
      "workbench.iconTheme"                    = "material-icon-theme";
      "terminal.integrated.defaultProfile.linux" = "zsh";
      "files.autoSave"                         = "onFocusChange";
      "git.autofetch"                          = true;
      "extensions.autoUpdate"                  = false;   # declarative config: no auto-updates
    };
  };

  # Cursor — available as pkgs.code-cursor in nixpkgs-unstable.
  # Syncs VS Code settings on first launch.
  home.packages = [ pkgs.code-cursor ];
}
