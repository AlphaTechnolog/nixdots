{ inputs, pkgs, system }: with inputs; [
  (
    final: _: let
      inherit (final) system;
    in
      (with nixpkgs-f2k.packages.${system}; {
        awesome = awesome-git;
        picom = picom-git;
      }) // {
        nvchad-source = inputs.nvchad;
      }
  )
]