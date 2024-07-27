{
  systems = [ "x86_64-linux" ];

  perSystem =
    { pkgs, inputs', ... }:
    {
      packages = {
        # instant repl with automatic flake loading
        thorium = pkgs.callPackage ./thorium.nix { };
      };
    };
}
