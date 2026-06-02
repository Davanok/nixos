{ stdenv }:

stdenv.mkDerivation {
  pname = "jetbra";
  version = "1.0";

  src = ./.;
  
  installPhase = ''
mkdir -p $out
cp -r * $out/
  '';
}