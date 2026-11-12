{
  flake.nixosModules.console =
    { lib, ... }:
    {
      programs.starship = {
        enable = true;
        enableNushellIntegration = true;
        enableBashIntegration = true;
        settings = {
          add_newline = true;
          command_timeout = 1000;
          format = lib.concatStrings [
            "[](fg:black)"
            "$sudo"
            "$username"
            "[](fg:black) "
            "$shell"
            "$directory"
            "$git_branch"
            "$git_status"
            "$fill"
            "$bun"
            "$c"
            "$elixir"
            "$elm"
            "$golang"
            "$haskell"
            "$java"
            "$julia"
            "$nodejs"
            "$nim"
            "$rust"
            "$scala"
            "$conda"
            "$python"
            "$direnv"
            "$time\n"
            "$character"
          ];
          profiles.transient = lib.concatStrings [
            "[](fg:black)"
            "$sudo"
            "[ 󰧱 ](bg:black fg:purple)"
            "[](fg:black)\n"
            " [∙](bold fg:purple) "
          ];
          profiles.sudo_prompt = lib.concatStrings [
            "[](fg:black)[  ](bg:black fg:cyan)[](fg:black) "
            "[](fg:cyan)  "
          ];
          continuation_prompt = " [∙](bold fg:purple)   ";
          character = {
            format = " $symbol ";
            success_symbol = "[󱞪](bold fg:purple)";
            error_symbol = "[󱞪](bold fg:red)";
          };
          fill = {
            style = "fg:black";
            symbol = "=";
          };
          username = {
            disabled = false;
            format = "[ 󰧱 $user ]($style)";
            show_always = true;
            style_root = "bg:black fg:red";
            style_user = "bg:black fg:purple";
          };
          sudo = {
            disabled = false;
            format = "[ $symbol ]($style)";
            style = "bg:black fg:cyan";
            symbol = "";
          };
          shell = {
            disabled = false;
            format = "[](fg:black)[  $indicator ]($style)[](fg:black) ";
            style = "bg:black fg:cyan";
          };
          git_branch = {
            format = "[ $symbol $branch ]($style)";
            style = "fg:blue";
            symbol = "";
          };
          git_status = {
            ahead = "⇡\($count\)";
            behind = "⇣\($count\)";
            deleted = "✘\($count\)";
            disabled = false;
            diverged = "⇕\[⇡\($ahead_count\)⇣\($behind_count\)\]";
            format = "([$all_status$ahead_behind ]($style))";
            modified = "[!\($count\)](fg:yellow)";
            renamed = "[»\($count\)](fg:yellow)";
            staged = "[++\($count\)](fg:yellow)";
            stashed = "[\$](fg:yellow)";
            style = "fg:red";
            untracked = "[?\($count\)](fg:yellow)";
            up_to_date = "[✓](bg:black fg:blue)";
          };
          directory = {
            format = "[](fg:black)[ $path ]($style)[](fg:black) ";
            style = "bg:black fg:green";
            truncation_length = 3;
            truncation_symbol = "…/";
            substitutions = {
              Blender = "  ";
              Documents = " 󰈙 ";
              Downloads = "  ";
              Godot = "  ";
              Java = "  ";
              Minecraft = " 󰍳 ";
              Music = "  ";
              Pictures = "  ";
              Projects = "  ";
              Python = "  ";
              Rust = "  ";
              Web = "  ";
              Streaming = " 󰄄 ";
            };
          };
          time = {
            disabled = false;
            format = " [](fg:black)[ $time 󰴈 ]($style)[](fg:black)";
            style = "bg:black fg:cyan";
            time_format = "%R";
          };
          direnv = {
            disabled = false;
            format = " [](fg:black)[ $symbol ($allowed $loaded) ]($style)[](fg:black)";
            symbol = "";
            style = "bg:black fg:green";
            allowed_msg = "󰄬";
            not_allowed_msg = "";
            denied_msg = "";
            loaded_msg = "";
            unloaded_msg = "";
          };
        };
      };
    };
}
