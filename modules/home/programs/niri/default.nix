{ config, pkgs, ... }:

{
  # Main Config Entry Point
  xdg.configFile."niri/config.kdl".source = ./config.kdl;
  
  # Static KDL files
  xdg.configFile."niri/binds.kdl".source = ./binds.kdl;
  xdg.configFile."niri/environment.kdl".source = ./environment.kdl;
  xdg.configFile."niri/rules.kdl".source = ./rules.kdl;
  xdg.configFile."niri/dms.kdl".source = ./dms.kdl;
  xdg.configFile."niri/spawn.kdl".source = ./spawn.kdl;
}
