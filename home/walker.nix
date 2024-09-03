{ ... }:
{
  programs.walker = {
    enable = true;
    # runAsService = true;

    # All options from the config.json can be used here.
    config = {
      ui = {
        fullscreen = true;
        width = 800;
        anchors = {
          top = true;
          bottom = true;
        };
      };
      list = {
        height = 500;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
      search = {
        placeholder = "Search";

      };
    };

  };
}
