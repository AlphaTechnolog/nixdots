{ inputs, pkgs, system }: with inputs; [
  nur.overlay
  (
    final: _: let
      inherit (final) system;
    in
      (with nixpkgs-f2k.packages.${system}; {
        awesome = awesome-git;
        picom = picom-git;
      }) // {
        nvim-config-source = inputs.nvim-config;
      }
  )
]