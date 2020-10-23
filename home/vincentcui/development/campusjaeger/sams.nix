with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "sams";
  buildInputs = [
    zlib
    autoconf
    automake
    nodejs-10_x
  ];
  shellHook = ''
    LD=$CC
  '';
}