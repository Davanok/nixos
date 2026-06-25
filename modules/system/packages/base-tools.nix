{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    _7zz-rar
    exiftool
    gcc
    duckdb
  ];
}
