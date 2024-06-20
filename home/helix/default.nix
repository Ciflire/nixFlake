{ lib, pkgs, ... }:
{
  programs.helix = {
    enable = true;
    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
      }
      {
        name = "typst";
        auto-format = true;
        formatter.command = "${pkgs.typstyle}/bin/typstyle";
      }
    ];
    settings = lib.mkForce {
      theme = "stylix";

      editor = {
        line-number = "relative";
        mouse = true;
        cursorline = true;
        cursorcolumn = true;
        auto-save = true;
        # completion-replace = true;
        bufferline = "multiple";
        color-modes = true;
        completion-trigger-len = 1;
        preview-completion-insert = false;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        statusline = {
          left = [
            "mode"
            "spinner"
            "diagnostics"
          ];
          center = [ "file-name" ];
          right = [
            "selections"
            "position"
            "file-encoding"
            "file-line-ending"
            "file-type"
          ];
          separator = "│";
          mode.normal = "NORMAL";
          mode.insert = "INSERT";
          mode.select = "SELECT";
        };
        # lsp = {
        #   display-inlay-hints = true;
        # };
        file-picker = {
          hidden = false;
          git-ignore = true;
          follow-symlinks = true;
        };
        soft-wrap = {
          enable = true;
        };
      };
      keys = {
        normal = {
          C-A-j = [
            "ensure_selections_forward"
            "extend_to_line_bounds"
            "extend_char_right"
            "extend_char_left"
            "delete_selection"
            "add_newline_below"
            "move_line_down"
            "replace_with_yanked"
          ];
          C-A-k = [
            "ensure_selections_forward"
            "extend_to_line_bounds"
            "extend_char_right"
            "extend_char_left"
            "delete_selection"
            "move_line_up"
            "add_newline_above"
            "move_line_up"
            "replace_with_yanked"
          ];
          "space" = {
            h = "signature_help";
          };
          X = "extend_line_above";
          up = "no_op";
          down = "no_op";
          left = "no_op";
          right = "no_op";

        };
        insert = {
          C-backspace = "delete_word_backward";
        };
      };
    };
  };
}
