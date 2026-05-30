{ ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "JetBrainsMono Nerd Font:size=10";
        font-size-adjustment = 1;
      };
    };
  };

  home.sessionVariables.TERMCMD = "foot";
}