{ stdenv, unzip }:

stdenv.mkDerivation {
  pname = "jetbra";
  version = "1.0";

  src = ./jetbra.zip;

  nativeBuildInputs = [ unzip ];

  unpackPhase = ''
    unzip $src
  '';
  
  installPhase = ''
    mkdir -p $out
    cp -r * $out/
  '';
}