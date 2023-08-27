{ lib, stdenv, hyprland, pkgs, }:
stdenv.mkDerivation rec {
  name = "hyprload-${version}";
  version = "0.1.0";
  src = ./.;

  nativeBuildInputs = with pkgs; [
    hyprland
    pkg-config
    jq
    wayland-scanner
    makeWrapper
  ];

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/lib
    cp split-monitor-workspaces.so $out/lib
  '';

  meta = with lib; {
    homepage = "https://github.com/Duckonaut/hyprload";
    description =
      "A small plugin to provide awesome/dwm-like behavior with workspaces: split them between monitors and provide independent numbering";
    platforms = platforms.linux;
  };
}
