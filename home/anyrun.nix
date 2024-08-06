{ pkgs, inputs, ... }:
let
  input_anyrun = inputs.anyrun.packages.${pkgs.system};
in
{
  programs.anyrun = {
    enable = true;
    extraCss = ''
      .window{
        background:none;
      }
    '';
  };
}
