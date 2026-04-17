{ pkgs, lib, inputs, config, ... }:

let
  repo = "${config.home.homeDirectory}/hnc";

  # ChatGPTBox XPI built in the modules repo (packages/chatgptbox.nix).
  # After the first build, confirm the real extension ID with:
  #   unzip -p ${chatgptboxXpi} manifest.json | jq '.browser_specific_settings.gecko.id'
  # Replace "chatgptbox@local" in ExtensionSettings with that value.
  chatgptboxXpi = inputs.my-modules.packages.${pkgs.system}.chatgptbox;

in
{
  # ── Palefox Firefox theme ─────────────────────────────────────────────────────
  # Provides vertical tabs (via Sideberry from NUR), compact CSS, and a clean UI.
  # Works alongside programs.firefox below — palefox handles CSS/prefs,
  # we handle policies and extensions.
  programs.palefox = {
    enable   = true;
    # profile defaults to "default-release" — change if your profile name differs
    autohide = false;
  };

  # ── Firefox policies + extensions ─────────────────────────────────────────────
  programs.firefox = {
    enable = true;

    # Enterprise policies written to /etc/firefox/policies/policies.json.
    # Applied system-wide before any profile loads.
    policies = {
      DisableTelemetry        = true;
      DisableFirefoxStudies   = true;
      DisablePocket           = true;
      NoDefaultBookmarks      = true;
      DontCheckDefaultBrowser = true;
      OverrideFirstRunPage    = "";
      OverridePostUpdatePage  = "";

      ExtensionSettings = let
        moz = short: "https://addons.mozilla.org/firefox/downloads/latest/${short}/latest.xpi";
      in {
        "*".installation_mode = "blocked"; # deny anything not explicitly listed

        # ChatGPTBox – built from GitHub source (packages/chatgptbox.nix in modules repo)
        # TODO: replace key with real ID from:
        #   unzip -p ${chatgptboxXpi} manifest.json | jq '.browser_specific_settings.gecko.id'
        "chatgptbox@local" = {
          installation_mode = "force_installed";
          install_url       = "file://${chatgptboxXpi}";
        };

        # Tridactyl – Vim keybindings for Firefox
        "tridactyl.vim@cmcaine.co.uk" = {
          installation_mode = "force_installed";
          install_url       = moz "tridactyl";
        };

        # Unhook – Remove YouTube recommendations and distractions
        "extension@unhook.app" = {
          installation_mode = "force_installed";
          install_url       = moz "unhook-for-youtube";
        };

        # uBlock Origin – Ad and tracker blocker
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url       = moz "ublock-origin";
        };

        # LeechBlock NG – Site/time limiter for focus
        "leechblockng@proginosko.com" = {
          installation_mode = "force_installed";
          install_url       = moz "leechblock-ng";
        };

        # Auto Tab Discard – Suspend background tabs to save memory
        "{c2c003ee-bd69-42a2-b0e9-6f34222cb046}" = {
          installation_mode = "force_installed";
          install_url       = moz "auto-tab-discard";
        };

        # Bitwarden – Password manager
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url       = moz "bitwarden-password-manager";
        };

        # Smart TOC – Auto-generated table of contents for pages
        "smarttoc@elyees.net" = {
          installation_mode = "force_installed";
          install_url       = moz "smart_toc";
        };

        # Sideberry – installed by palefox via NUR; allow it through the block
        "{3c078156-979c-498b-8990-7f0f5cfc3a30}" = {
          installation_mode = "normal_installed";
        };
      };

      # Preferences set via policy (about:config equivalent).
      # Status "locked" prevents user override; "default" allows it.
      Preferences = {
        # Privacy
        "privacy.trackingprotection.enabled"                = { Value = true;  Status = "default"; };
        "privacy.trackingprotection.socialtracking.enabled" = { Value = true;  Status = "default"; };
        "browser.send_pings"                                = { Value = false; Status = "default"; };
        "beacon.enabled"                                    = { Value = false; Status = "default"; };

        # Telemetry – locked so it can't be re-enabled
        "toolkit.telemetry.unified"                    = { Value = false; Status = "locked"; };
        "toolkit.telemetry.enabled"                    = { Value = false; Status = "locked"; };
        "datareporting.policy.dataSubmissionEnabled"   = { Value = false; Status = "locked"; };

        # Performance – hardware-accelerated rendering and video decode
        "gfx.webrender.all"                            = { Value = true; Status = "default"; };
        "media.ffmpeg.vaapi.enabled"                   = { Value = true; Status = "default"; };
        "media.hardware-video-decoding.force-enabled"  = { Value = true; Status = "default"; };

        # Startup / new tab – blank to avoid activity-stream noise
        "browser.startup.homepage"        = { Value = "about:blank"; Status = "default"; };
        "browser.newtabpage.enabled"      = { Value = false;         Status = "default"; };

        # UI – compact density, hide bookmarks bar, keep window on last tab close
        "browser.toolbars.bookmarks.visibility" = { Value = "never"; Status = "default"; };
        "browser.uidensity"                     = { Value = 1;       Status = "default"; };
        "browser.tabs.closeWindowWithLastTab"   = { Value = false;   Status = "default"; };

        # Security – HTTPS-only mode, no DNS prefetch
        "dom.security.https_only_mode" = { Value = true;  Status = "default"; };
        "network.dns.disablePrefetch"  = { Value = true;  Status = "default"; };
        "network.prefetch-next"        = { Value = false; Status = "default"; };
      };
    };
  };

  # ── Tridactyl dotfile ────────────────────────────────────────────────────────
  # Tridactyl reads ~/.config/tridactyl/tridactylrc (XDG path on Linux).
  # Symlinked to the live file in the repo; edit and reload (:source) instantly.
  home.file.".config/tridactyl/tridactylrc".source =
    config.lib.file.mkOutOfStoreSymlink "${repo}/config/tridactyl/tridactylrc";

  # ── Chromium ─────────────────────────────────────────────────────────────────
  programs.chromium = {
    enable = true;

    # Extensions by Chrome Web Store ID
    extensions = [
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
      { id = "nngceckbapebfimnlniiiahkandclblb"; } # Bitwarden
      { id = "mnjggcdmjocbbbhaepdhchncahnbgone"; } # SponsorBlock
    ];

    commandLineArgs = [
      "--ozone-platform=wayland"                              # native Wayland (Niri)
      "--enable-features=VaapiVideoDecoder,VaapiVideoEncoder"
      "--disable-features=UseChromeOSDirectVideoDecoder"
      "--enable-webrtc-pipewire-capturer"
      "--force-dark-mode"
    ];

    extraOpts = {
      BrowserSignin             = 0;     # disable sign-in prompt
      SyncDisabled              = true;
      PasswordManagerEnabled    = false; # defer to Bitwarden
      AutofillAddressEnabled    = false;
      AutofillCreditCardEnabled = false;
      MetricsReportingEnabled   = false;
      # DuckDuckGo as default search
      DefaultSearchProviderEnabled   = true;
      DefaultSearchProviderName      = "DuckDuckGo";
      DefaultSearchProviderSearchURL = "https://duckduckgo.com/?q={searchTerms}";
    };
  };
}
