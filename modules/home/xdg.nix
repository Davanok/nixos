{ config, pkgs, ... }:

{
  xdg = {
    mimeApps.enable = true;
    configFile."mimeapps.list".enable = false;
    dataFile."applications/mimeapps.list".force = true;

    userDirs = {
      enable = true;
      download = "~/Downloads";
      pictures = "~/Pictures";
      desktop = "~/garbage";
      documents = "~/garbage";
      music = "~/garbage";
      publicShare = "~/garbage";
      templates = "~/garbage";
      videos = "~/garbage";
    };

    portal = {
      enable = true;

      extraPortals = with pkgs; [
        xdg-desktop-portal-gtk
        xdg-desktop-portal-gnome
        xdg-desktop-portal-termfilechooser
      ];

      config.common = {
        default = [
          "gtk"
        ];
        
        "org.freedesktop.impl.portal.Access" = [ "gtk" ];
        "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "xdg-desktop-portal-termfilechooser" ];
      };
    };
    configFile."xdg-desktop-portal-termfilechooser/config" = {
      force = true;
      text = ''
        [filechooser]
        cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
       '';
    };
  };
}
