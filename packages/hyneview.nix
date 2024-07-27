{ appimageTools }:
let
  pname = "hyneview";
  version = "4.7.4";

  src = ./diateam.AppImage;
in
appimageTools.wrapType2 {
  inherit pname version src;
  extraPkgs = pkgs: [ pkgs.libthai ];
}
