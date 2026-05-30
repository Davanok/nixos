{ ... }:

{
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
    trustedInterfaces = [ "tun0" ];
    allowPing = true;
  };
}
