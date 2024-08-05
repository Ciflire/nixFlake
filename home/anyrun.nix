{ inputs, pkgs, ... }:
let
  input_anyrun = inputs.anyrun.packages.${pkgs.system};
in
{

  programs.anyrun = {
    enable = true;
    config = {
      plugins = [
        # An array of all the plugins you want, which either can be paths to the .so files, or their packages
        input_anyrun.application
        input_anyrun.randr
        input_anyrun.symbols
      ];
    };
    x = {
      fraction = 0.5;
    };
    y = {
      fraction = 0.3;
    };
    width = {
      fraction = 0.3;
    };
    hideIcons = false;
    ignoreExclusiveZones = false;
    layer = "overlay";
    hidePluginInfo = false;
    closeOnClick = false;
    showResultsImmediately = false;
    maxEntries = null;
  };

}
