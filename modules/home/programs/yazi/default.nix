{ pkgs, ... }:

{
    xdg.configFile = {
        "yazi/plugins/smart-tab.yazi/main.lua".source = ./smart-tab.lua;
        "yazi/plugins/smart-switch.yazi/main.lua".source = ./smart-switch.lua;
        
    };

    programs.yazi = {
        enable = true;
        shellWrapperName = "y";

        plugins = {
            smart-enter = pkgs.yaziPlugins.smart-enter;
            smart-paste = pkgs.yaziPlugins.smart-paste;
            mount = pkgs.yaziPlugins.mount;

            # bypass = pkgs.yaziPlugins.bypass;
            # chmod = pkgs.yaziPlugins.chmod;
            # compress = pkgs.yaziPlugins.compress;
            # diff = pkgs.yaziPlugins.diff;
            # drag = pkgs.yaziPlugins.drag;
            # duckdb = pkgs.yaziPlugins.duckdb;
            # dupes = pkgs.yaziPlugins.dupes;
            # eza-preview = pkgs.yaziPlugins.eza-preview;
            # file-extra-metadata = pkgs.yaziPlugins.file-extra-metadata;
            # full-border = pkgs.yaziPlugins.full-border;
            # gitui = pkgs.yaziPlugins.gitui;
            # gvfs = pkgs.https://github.com/boydaihungst/gvfs.yazi;
            # hexyl = pkgs.yaziPlugins.hexyl;
            # lsar = pkgs.yaziPlugins.lsar;
            # mediainfo = pkgs.yaziPlugins.mediainfo;
            # mime-ext = pkgs.yaziPlugins.mime-ext;
            # no-status = pkgs.yaziPlugins.no-status;
            # office = pkgs.yaziPlugins.office;
            # ouch = pkgs.yaziPlugins.ouch;
            # piper = pkgs.yaziPlugins.piper;
            # recycle-bin = pkgs.yaziPlugins.recycle-bin;
            # restore = pkgs.yaziPlugins.restore;
            # rich-preview = pkgs.yaziPlugins.rich-preview;
            # starship = pkgs.yaziPlugins.starship;
            # sudo = pkgs.yaziPlugins.sudo;
            # toggle-pane = pkgs.yaziPlugins.toggle-pane;
            # torrent-preview = pkgs.yaziPlugins.torrent-preview;
            # wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
            # yatline = pkgs.yaziPlugins.yatline;
            # yatline-catppuccin = pkgs.yaziPlugins.yatline-catppuccin;
        };

        keymap = {
            mgr.prepend_keymap = [
                {
                    on = "!";
                    run = "shell '$SHELL' --block";
                    desc = "Open $SHELL here";
                }
                {
                    on = "<Enter>";
                    run = "plugin smart-enter";
                    desc = "Enter the child directory, or open the file";
                }
                {
                    on = "o";
                    run = "plugin smart-enter";
                    desc = "Enter the child directory, or open the file";
                }
                {
                    on = "p";
                    run = "plugin smart-paste";
                    desc = "Paste into the hovered directory or CWD";
                }
                {
                    on = [ "t" "t" ];
                    run = "plugin smart-tab";
                    desc = "Create a tab and enter the hovered directory";
                }
                {
                    on = [ "M" ];
                    run = "plugin mount";
                    desc = "Open mount menu";
                }
            ] ++ builtins.genList (x: {
                on = toString (x + 1);
                run = "plugin smart-switch ${toString x}";
                desc = "Switch or create tab ${toString (x + 1)}";
            }) 10;

            input.prepend_keymap = [
                {
                    on = "<Esc>";
                    run = "close";
                    desc = "Cancel input";
                }
            ];
        };
    };
}