{ pkgs, globals, ... }:

{
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;

  services = {
    power-profiles-daemon.enable = true;
    upower.enable = true;

    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    
    displayManager.dms-greeter =  {
      enable = true;
      compositor.name = "niri";
      configHome = "/home/${globals.username}";
      logs = {
        save = true;
        path = "/tmp/dms-greeter.log";
      };
    };

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
    udisks2.enable = true;

    udev.packages = [
      pkgs.platformio-core
    ];
  };

  security = {
    polkit.enable = true;
  };

  systemd = {
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
    };
  };
}
