{ lib, stdenv, hyprland, pkgs, }:
stdenv.mkDerivation rec {
  pname = "split-monitor-workspaces";
  version = "0.1.0";
  src = ../.;

  nativeBuildInputs = with pkgs; [
    hyprland
    pkg-config
    jq
    wayland-scanner
    makeWrapper
  ];

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  patches = [
    "nix/makefile.patch"
  ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp split-monitor-workspaces.so $out/lib/lib${pname}.so
  '';

  meta = with lib; {
    homepage = "https://github.com/Duckonaut/hyprload";
    description =
      "A small plugin to provide awesome/dwm-like behavior with workspaces: split them between monitors and provide independent numbering";
    platforms = platforms.linux;
  };
}
