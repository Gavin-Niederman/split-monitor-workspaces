{ pkgs, hyprland }:
pkgs.callPackage ./derivation.nix { hyprland = hyprland; }