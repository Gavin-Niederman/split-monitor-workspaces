{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.hyprland.url = "github:hyprwm/Hyprland";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs, flake-utils, hyprland, ... }:
    (flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system};
      in with pkgs; rec {
        devShell = pkgs.mkShell {
          buildInputs = [hyprland.packages.${system}.hyprland];
          inputsFrom = [hyprland.packages.${system}.hyprland];
          HYPRLAND_HEADERS = "${hyprland.packages.${system}.hyprland.dev}/include";
        };
        packages = rec {
          split-monitor-workspaces = import ./nix/default.nix { hyprland = hyprland.packages.${system}.hyprland; pkgs = pkgs; };
          default = split-monitor-workspaces;
        };
        apps = rec {
          split-monitor-workspaces =
            flake-utils.lib.mkApp { drv = self.packages.${system}.default; };
          default = split-monitor-workspaces;
        };
      }));
      # // rec {
      #   overlay = overlays.default;
      #   overlays.default = (final: _: let in { split-monitor-workspaces = import ./default.nix { inherit hyprland; }; });
      # };
}
