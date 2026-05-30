{ config, pkgs, ... }:
let
  flake-path = "/etc/nixos";
in {
  programs.fish = {
    enable = true;
    generateCompletions = true;

    shellAliases = {
      # ===== NixOS rebuild =====
      ns = "sudo nixos-rebuild switch --flake ${flake-path}";
      nst = "sudo nixos-rebuild test --flake ${flake-path}";
      nsb = "sudo nixos-rebuild build --flake ${flake-path}";
      nsboot = "sudo nixos-rebuild boot --flake ${flake-path}";
  
      # rebuild + update flake
      nsu = "cd ${flake-path} && sudo nix flake update && sudo nixos-rebuild switch --flake .";
  
      # ===== Home Manager =====
      hms = "home-manager switch --flake ${flake-path}";
      hmb = "home-manager build --flake ${flake-path}";
  
      # ===== Flakes =====
      flake-update = "sudo nix flake update --flake ${flake-path}";
      flake-check = "nix flake check --flake ${flake-path}";
      flake-show = "nix flake show --flake ${flake-path}";
  
      # ===== Nix packages =====
      ni = "nix profile install";
      nr = "nix profile remove";
      nl = "nix profile list";
      nu = "nix profile upgrade";
  
      # ===== Nix shell =====
      nshell = "nix shell";
      ndev = "nix develop";
  
      # ===== Garbage collection =====
      ngc = "nix-collect-garbage -d";
      nopt = "nix store optimise";
  
      # ===== Search =====
      nsrch = "nix search nixpkgs";

      # ===== Helpers ====
      copy = "dms clipboard copy";

      ls = "eza";
      cd = "z";

      code = "codium";
    };

    shellInit = ''
      set fish_greeting
    '';

    interactiveShellInit = ''
      fastfetch
    '';
  };

}
