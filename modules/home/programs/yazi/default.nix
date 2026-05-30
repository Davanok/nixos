{ pkgs, ... }:

let
  mkKey = on: run: desc: { inherit on run desc; };

  # Tab switching: 1..9
  tabSwitchBinds =
    builtins.genList
      (x:
        mkKey
          (toString (x + 1))
          "plugin smart-switch ${toString x}"
          "Switch/create tab ${toString (x + 1)}")
      9;

in {
  xdg.configFile = {
    "yazi/plugins/smart-tab.yazi/main.lua".source = ./smart-tab.lua;
    "yazi/plugins/smart-switch.yazi/main.lua".source = ./smart-switch.lua;
  };

  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    shellWrapperName = "y";
    initLua = ./init.lua;

    plugins = with pkgs.yaziPlugins; {
      inherit 
        smart-enter
        mount
        compress
        starship
        duckdb;
    };

    settings = {
        mgr = {
          show_hidden = true;
          sort_by = "natural";
          sort_sensitively = false;
          sort_dir_first = true;
          sort_translit = true;
          linemode = "mtime";
        };
        plugin = {
            prepend_previewers = [
              { url = "*.csv";     run = "duckdb"; }
              { url = "*.tsv";     run = "duckdb"; }
              { url = "*.parquet"; run = "duckdb"; }
              { url = "*.xlsx";    run = "duckdb"; }
              { url = "*.db";      run = "duckdb"; }
              { url = "*.duckdb";  run = "duckdb"; }
            ];
            prepend_preloaders = [  
              { url = "*.csv";     run = "duckdb"; multi = false; }
              { url = "*.tsv";     run = "duckdb"; multi = false; }
              { url = "*.parquet"; run = "duckdb"; multi = false; }
              { url = "*.xlsx";    run = "duckdb"; multi = false; }
            ];
        };
    };

    keymap = {
      mgr.prepend_keymap = [
          (mkKey "!" "shell '$SHELL' --block" "Open shell here")

          (mkKey "<Enter>" "plugin smart-enter" "Open file / enter directory")
          (mkKey "o" "plugin smart-enter" "Open file / enter directory")

          (mkKey [ "t" "t" ] "plugin smart-tab" "Create tab from hovered directory")

          (mkKey "M" "plugin mount" "Open mount manager")
        ]

        ++ tabSwitchBinds

        ++ [
          (mkKey [ "C" "a" ] "plugin compress" "Compress")

          (mkKey [ "C" "p" ] "plugin compress -p"
            "Compress with password")

          (mkKey [ "C" "h" ] "plugin compress -ph"
            "Compress with password + header")

          (mkKey [ "C" "l" ] "plugin compress -l"
            "Compress with compression level")

          (mkKey [ "C" "u" ] "plugin compress -phl"
            "Compress with password + header + level")
        ]
        
        ++ [
          (mkKey [ "H" ] "plugin duckdb -1" "Scroll one column to the left")
          (mkKey [ "L" ] "plugin duckdb +1" "Scroll one column to the right")
          (mkKey [ "g" "o" ] "plugin duckdb -open" "Open with duckdb")
          (mkKey [ "g" "u" ] "plugin duckdb -ui" "Open with duckdb ui")
        ];

      input.prepend_keymap = [
        (mkKey "<Esc>" "close" "Cancel input")
      ];
    };
  };
}