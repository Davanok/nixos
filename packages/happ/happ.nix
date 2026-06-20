{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "happ-desktop";
  version = "2.17.1";

  src = pkgs.fetchurl {
    url = "https://github.com/Happ-proxy/happ-desktop/releases/download/${version}/Happ.linux.x64.deb";
    sha256 = "e5b9e529d4d4c6ff4525306ac64c4cb9c539532ca00f7035c3d56eb7a5fca1be";
  };

  nativeBuildInputs = with pkgs; [
    dpkg
    autoPatchelfHook
    makeWrapper
    qt6.wrapQtAppsHook
  ];

  buildInputs = with pkgs; [
    stdenv.cc.cc.lib
    glib
    dbus
    libGL
    libx11
    libsm
    libice
    libxext
    libxi
    libxtst
    e2fsprogs
    fontconfig
    freetype
    libgpg-error
    qt6.qtwayland
    openssl
  ];

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/happ
    mkdir -p $out/share/applications
    mkdir -p $out/bin

    dpkg -x $src .
    cp -r opt/happ/* $out/happ/

    if [ -d "usr/share" ]; then
      cp -r usr/share/* $out/share/
    fi

    wrapProgram $out/happ/bin/Happ \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.openssl ]}" \
      --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    wrapProgram $out/happ/bin/happd \
      --prefix LD_LIBRARY_PATH : "${pkgs.lib.makeLibraryPath [ pkgs.openssl ]}" \
      --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    ln -s $out/happ/bin/Happ $out/bin/happ

    runHook postInstall
  '';
}