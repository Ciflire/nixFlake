{ ... }:
{
  programs.walker = {
    enable = true;
    runAsService = true;

    # All options from the config.json can be used here.
    config = {
      search.placeholder = "Search";
      fullscreen = true;
      list = {
        height = 200;
      };
      websearch.prefix = "?";
      switcher.prefix = "/";
    };

  };
}