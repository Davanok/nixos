{ pkgs, globals, config, ... }:

let
  lock-value = value: {
    Value = value;
    Status = "locked";
  };
  extensions = [
    "uBlock0@raymondhill.net"
    "jid1-MnnxcxisBPnSXQ@jetpack"
    "jid1-BoFifL9Vbdl2zQ@jetpack"
    "private-relay@firefox.com"
    "idcac-pub@guus.ninja"
  ];
in {
  programs.firefox = {
    enable = true;
    languagePacks = [ "en-US" "ru" ];

    /* ---- POLICIES ---- */
    # Check about:policies#documentation for options.
    policies = {
      DisableAppUpdate = true;
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      EnableTrackingProtection = {
        Value= true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
      };
      UserMessaging = {
        ExtensionRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = true;
        MoreFromMozilla = false;
        FirefoxLabs = true;
      };
      DisablePocket = true;
      OverrideFirstRunPage = "";
      OverridePostUpdatePage = "";
      DontCheckDefaultBrowser = true;
      DisplayBookmarksToolbar = "newtab"; # alternatives: "always" or "never"
      DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
      SearchBar = "unified"; # alternative: "separate"
      DisableProfileCreation = true;
      SearchEngines = {
        Add = [
          {
              Name = "DuckDuckGo";
              URLTemplate = "https://duckduckgo.com/?q={searchTerms}&ia=web";
              IconURL = "https://duckduckgo.com/favicon.ico";
              Alias = "@ddg";
              Description = "Duckduckgo";
          }
          {
            Name = "Github";
            URLTemplate = "https://github.com/search?q={searchTerms}&type=repositories";
            IconURL = "https://github.com/favicon.ico";
            Alias = "@gh";
            Description = "Serch in github repositories";
          }
          {
            Name = "NixSearch";
            URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
            IconURL = "https://nixos.org/favicon.ico";
            Alias = "@ns";
            Description = "Search in nixos search";
          }
        ];
        Remove = [
          "Bing"
          "Ecosia"
          "Perplexity"
          "Wikipedia (en)"
        ];
        Default = "Google";
      };
      ExtensionSettings =
        (builtins.listToAttrs (builtins.map (id: {
          name = id;
          value = {
            install_url =
              "https://addons.mozilla.org/firefox/downloads/latest/${id}/latest.xpi";
            installation_mode = "force_installed";
          };
        }) extensions))
        // {
          "*".installation_mode = "blocked";
        };
      
      Preferences = {
        "browser.uidensity" = lock-value 1;
        #### FEATURES ###
        "layout.spellcheckDefault" = lock-value 1;
        # Use the systems native filechooser portal
        "widget.use-xdg-desktop-portal.file-picker" = lock-value true;
        "media.webrtc.camera.allow-pipewire" = lock-value true;
        "browser.download.always_ask_before_handling_new_types" = lock-value true;
        #### DEBLOAT ###
        "browser.discovery.enabled" = lock-value false;
        "app.shield.optoutstudies.enabled" = lock-value false;
        "browser.topsites.contile.enabled" = lock-value false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = lock-value false;
        "browser.urlbar.trending.featureGate" = lock-value false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-value false;
        "browser.newtabpage.activity-stream.feeds.snippets" = lock-value false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-value false;
        "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-value false;
        "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-value false;
        "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-value false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-value false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-value false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-value false;
        # Privacy: Disable automatic opening in new windows (manually still works)
        # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/9881
        "browser.link.open_newwindow" = lock-value 3;
        # Privacy: Set all window open modes to abide above method
        "browser.link.open_newwindow.restriction"= 0;

        #### PRIVACY ###
        "privacy.resistFingerprinting" = lock-value "true";
        # disable sending downloaded files to the internet
        "browser.safebrowsing.downloads.remote.enabled" = lock-value false;
        "network.dns.disablePrefetch" = lock-value false;
        # redundancy: disable network prefetching
        "network.predictor.enabled" = lock-value false;
        # disable preloading websites when hovering over links
        "network.http.speculative-parallel-limit" = lock-value 0;
        # disable connecting to bookmarks when hovering over them
        "browser.places.speculativeConnect.enabled" = lock-value "false";
        "privacy.globalprivacycontrol.enabled" = lock-value true;
        "privacy.clearOnShutdown_v2.cookiesAndStorage" = lock-value true;
        "privacy.fingerprintingProtection" = lock-value true;

        "browser.contentblocking.category" = lock-value "strict";
        "extensions.pocket.enabled" = lock-value false;
        "browser.search.suggest.enabled" = lock-value false;
        "browser.search.suggest.enabled.private" = lock-value false;
        "browser.urlbar.suggest.searches" = lock-value false;
        # store media in cache only on private browsing
        "browser.privatebrowsing.forceMediaMemoryCache" = lock-value true;
        "network.http.referer.XOriginTrimmingPolicy" = lock-value 2;
        # Privacy: Disable CSP reporting
        # https://bugzilla.mozilla.org/show_bug.cgi?id=1964249
        "security.csp.reporting.enabled" = lock-value false;

        #### SECURITY ###
        #"browser.formfill.enable" = lock-value false;
        "pdfjs.enableScripting" = lock-value false;
        #"signon.autofillForms" = false
        # UNCLEAR
        "signon.formlessCapture.enabled" = lock-value false;
        # prevent scripts from moving or resizing windows
        "dom.disable_window_move_resize" = lock-value true;
        # Security: Disable remote debugging feature
        # https://gitlab.torproject.org/tpo/applications/tor-browser/-/issues/16222
        "devtools.debugger.remote-enabled" = lock-value false;
        # Security: Restrict directories from which extensions can be loaded (Unclear)
        # https://archive.is/DYjAM
        "extensions.enabledScopes" = lock-value 5;

        #### SSL ###
        # Security: Require safe SSL negotiation to avoid potentially MITMed sites
        "security.ssl.require_safe_negotiation" = lock-value true;
        # Security: Disable TLS1.3 0-RTT as key encryption may not be forward secret
        # https://github.com/tlswg/tls13-spec/issues/1001
        "security.tls.enable_0rtt_data" = lock-value 2;
        # Security: Enable strict public key pinning, prevents some MITM attacks
        "security.cert_pinning.enforcement_level" = lock-value 2;
        # Security: Enable CRLite to ensure that revoked certificates are detected
        "security.pki.crlite_mode" = lock-value 2;
        # Security: Treat unsafe negotiation as broken
        # https://wiki.mozilla.org/Security:Renegotiation
        # https://bugzilla.mozilla.org/1353705
        "security.ssl.treat_unsafe_negotiation_as_broken" = lock-value true;
        #  Security: Display more information on Insecure Connection warning pages
        # Test: https://badssl.com
        "browser.xul.error_pages.expert_bad_cert" = lock-value true;
        "browser.uiCustomization.state" = builtins.toJSON ({
          placements = {
            "widget-overflow-fixed-list" = [];

            "unified-extensions-area" = map
              (x:
                builtins.replaceStrings
                  [ "@" "." ]
                  [ "_" "_" ]
                  (pkgs.lib.toLower x)
                + "-browser-action"
              )
              extensions;

            "nav-bar" = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "customizableui-special-spring1"
              "vertical-spacer"
              "urlbar-container"
              "customizableui-special-spring2"
              "screenshot-button"
              "downloads-button"
              "unified-extensions-button"
            ];

            "toolbar-menubar" = [
              "menubar-items"
            ];

            "TabsToolbar" = [
              "firefox-view-button"
              "tabbrowser-tabs"
              "new-tab-button"
              "alltabs-button"
            ];

            "vertical-tabs" = [];

            "PersonalToolbar" = [
              "personal-bookmarks"
            ];
          };

          seen =
            [
              "developer-button"
              "screenshot-button"
            ]
            ++ map
              (x:
                builtins.replaceStrings
                  [ "@" "." ]
                  [ "_" "_" ]
                  (pkgs.lib.toLower x)
                + "-browser-action"
              )
              extensions;

          dirtyAreaCache = [
            "nav-bar"
            "vertical-tabs"
            "PersonalToolbar"
            "unified-extensions-area"
          ];

          currentVersion = 23;
          newElementCount = 6;
        });
      };
    };
  };
}