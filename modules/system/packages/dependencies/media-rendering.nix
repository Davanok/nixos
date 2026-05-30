{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpeg_7
    poppler
    imagemagick
    resvg
    orca-slicer
  ];
}
