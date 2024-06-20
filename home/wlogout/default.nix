{ ... }:
{
  programs.wlogout = {
    enable = true;
    layout = [
      {
        "label" = "logout";
        "action" = "loginctl terminate-user $USER";
        "text" = "Logout";
        "keybind" = "e";
        circular = true;
      }
      {
        "label" = "shutdown";
        "action" = "systemctl poweroff";
        "text" = "Shutdown";
        "keybind" = "s";
      }
      {
        "label" = "suspend";
        "action" = "systemctl suspend";
        "text" = "Suspend";
        "keybind" = "u";
      }
      {
        "label" = "reboot";
        "action" = "systemctl reboot";
        "text" = "Reboot";
        "keybind" = "r";
      }
    ];
    style = ''
            * {
      	background-image: none;
      	box-shadow: none;
      }

      window {
      	background-color: @headerbar_border_color;
      }

      button {
        margin: 10px;
        border-radius: 0;
        border-color: @accent_color;
      	text-decoration-color: #FFFFFF;
        color: #FFFFFF;
      	background-color: @window_bg_color;
      	border-style: solid;
      	border-width: 1px;
      	background-repeat: no-repeat;
      	background-position: center;
      	background-size: 25%;
      }

      button:focus, button:active, button:hover {
      	background-color: #3700B3;
      	outline-style: none;
      }

      #logout {
          background-image: image(url("/nix/store/n2znc0cjx6wxd4xwp246pp7g469zyim3-wlogout-1.2.2/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
      }

      #suspend {
          background-image: image(url("/nix/store/n2znc0cjx6wxd4xwp246pp7g469zyim3-wlogout-1.2.2/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
      }


      #shutdown {
          background-image: image(url("/nix/store/n2znc0cjx6wxd4xwp246pp7g469zyim3-wlogout-1.2.2/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
      }

      #reboot {
          background-image: image(url("/nix/store/n2znc0cjx6wxd4xwp246pp7g469zyim3-wlogout-1.2.2/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
      }

    '';
  };
}
