{ self, ... }:
{
  flake.nixosModules.console =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      inherit (lib.generators) mkKeyValueDefault;
      kittyKeyValue = pkgs.formats.keyValue {
        listsAsDuplicateKeys = true;
        mkKeyValue = mkKeyValueDefault { } " ";
      };
    in
    {
      environment.systemPackages = [ pkgs.kitty ];
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.caskaydia-cove
        # nerd-fonts.symbols-only
        monocraft
        minecraftia
        miracode
      ];
      hjem.users.${config.preferences.user.name}.rum.programs.kitty = {
        enable = true;
        settings = {
          enable_audio_bell = "no";

          font_size = 10;
          font_family = "Monocraft";

          allow_remote_control = "yes";
          shell_integration = "enabled";

          tab_bar_style = "powerline";
          tab_powerline_style = "slanted";
          tab_title_template = ''" {index} {title} "'';

          cursor_shape = "beam";
          cursor_trail = 3;

          map = [
            "alt+1 goto_tab 1"
            "alt+2 goto_tab 2"
            "alt+3 goto_tab 3"
            "alt+4 goto_tab 4"
            "alt+5 goto_tab 5"
            "alt+6 goto_tab 6"
            "alt+7 goto_tab 7"
            "alt+8 goto_tab 8"
            "alt+9 goto_tab 9"
            "--allow-fallback=shifted,ascii ctrl+shift+d close_window"
            "ctrl+h previous_window"
            "ctrl+l next_window"
            "ctrl+w focus_visible_window"
            "ctrl+s swap_with_window"
            "ctrl+shift+w close_tab"
            "ctrl+t new_tab_with_cwd"
            "ctrl+shift+t new_tab"
          ];

          # symbol_map = [
          #   # "Nerd Fonts - Pomicons"
          #   "U+E000-U+E00D Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Powerline"
          #   "U+e0a0-U+e0a2,U+e0b0-U+e0b3 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Powerline Extra"
          #   "U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Symbols original"
          #   "U+e5fa-U+e62b Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Devicons"
          #   "U+e700-U+e7c5 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Font awesome"
          #   "U+f000-U+f2e0 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Font awesome extension"
          #   "U+e200-U+e2a9 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Octicons"
          #   "U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Font Linux"
          #   "U+F300-U+F313 Symbols Nerd Font Mono"
          #   #  Nerd Fonts - Font Power Symbols"
          #   "U+23fb-U+23fe,U+2b58-U+2b58 Symbols Nerd Font Mono"
          #   #  "Nerd Fonts - Material Design Icons"
          #   "U+f500-U+fd46 Symbols Nerd Font Mono"
          #   # "Nerd Fonts - Weather Icons"
          #   "U+e300-U+e3eb Symbols Nerd Font Mono"
          #   # Misc Code Point Fixes
          #   "U+21B5,U+25B8,U+2605,U+2630,U+2632,U+2714,U+E0A3,U+E615,U+E62B Symbols Nerd Font Mono"
          # ];
        };
        theme = {
          dark = kittyKeyValue.generate "dark-theme.auto.conf" {
            foreground = self.theme.rose-pine-dark.base05;
            background = self.theme.rose-pine-dark.base00;

            cursor = self.theme.rose-pine-dark.base0E;
            cursor_text_color = self.theme.rose-pine-dark.base05;

            selection_foreground = self.theme.rose-pine-dark.base05;
            selection_background = self.theme.rose-pine-dark.base0D;

            active_tab_foreground = self.theme.rose-pine-dark.base05;
            active_tab_background = self.theme.rose-pine-dark.base02;
            inactive_tab_foreground = self.theme.rose-pine-dark.base03;
            inactive_tab_background = self.theme.rose-pine-dark.base00;

            active_border_color = self.theme.rose-pine-dark.base09;
            inactive_border_color = self.theme.rose-pine-dark.base0D;

            color0 = self.theme.rose-pine-dark.base02;
            color8 = self.theme.rose-pine-dark.base03;

            color1 = self.theme.rose-pine-dark.base06;
            color9 = self.theme.rose-pine-dark.base06;

            color2 = self.theme.rose-pine-dark.base09;
            color10 = self.theme.rose-pine-dark.base09;

            color3 = self.theme.rose-pine-dark.base07;
            color11 = self.theme.rose-pine-dark.base07;

            color4 = self.theme.rose-pine-dark.base0A;
            color12 = self.theme.rose-pine-dark.base0A;

            color5 = self.theme.rose-pine-dark.base0B;
            color13 = self.theme.rose-pine-dark.base0B;

            color6 = self.theme.rose-pine-dark.base08;
            color14 = self.theme.rose-pine-dark.base08;

            color7 = self.theme.rose-pine-dark.base05;
            color15 = self.theme.rose-pine-dark.base05;
          };
          light = kittyKeyValue.generate "light-theme.auto.conf" {
            foreground = self.theme.rose-pine-dawn.base05;
            background = self.theme.rose-pine-dawn.base00;

            cursor = self.theme.rose-pine-dawn.base0E;
            cursor_text_color = self.theme.rose-pine-dawn.base05;

            selection_foreground = self.theme.rose-pine-dawn.base05;
            selection_background = self.theme.rose-pine-dawn.base0D;

            active_tab_foreground = self.theme.rose-pine-dawn.base05;
            active_tab_background = self.theme.rose-pine-dawn.base02;
            inactive_tab_foreground = self.theme.rose-pine-dawn.base03;
            inactive_tab_background = self.theme.rose-pine-dawn.base00;

            active_border_color = self.theme.rose-pine-dawn.base09;
            inactive_border_color = self.theme.rose-pine-dawn.base0D;

            color0 = self.theme.rose-pine-dawn.base02;
            color8 = self.theme.rose-pine-dawn.base03;

            color1 = self.theme.rose-pine-dawn.base06;
            color9 = self.theme.rose-pine-dawn.base06;

            color2 = self.theme.rose-pine-dawn.base09;
            color10 = self.theme.rose-pine-dawn.base09;

            color3 = self.theme.rose-pine-dawn.base07;
            color11 = self.theme.rose-pine-dawn.base07;

            color4 = self.theme.rose-pine-dawn.base0A;
            color12 = self.theme.rose-pine-dawn.base0A;

            color5 = self.theme.rose-pine-dawn.base0B;
            color13 = self.theme.rose-pine-dawn.base0B;

            color6 = self.theme.rose-pine-dawn.base08;
            color14 = self.theme.rose-pine-dawn.base08;

            color7 = self.theme.rose-pine-dawn.base05;
            color15 = self.theme.rose-pine-dawn.base05;
          };
          no-preference = kittyKeyValue.generate "no-preference-theme.auto.conf" {
            foreground = self.theme.rose-pine-moon.base05;
            background = self.theme.rose-pine-moon.base00;

            cursor = self.theme.rose-pine-moon.base0E;
            cursor_text_color = self.theme.rose-pine-moon.base05;

            selection_foreground = self.theme.rose-pine-moon.base05;
            selection_background = self.theme.rose-pine-moon.base0D;

            active_tab_foreground = self.theme.rose-pine-moon.base05;
            active_tab_background = self.theme.rose-pine-moon.base02;
            inactive_tab_foreground = self.theme.rose-pine-moon.base03;
            inactive_tab_background = self.theme.rose-pine-moon.base00;

            active_border_color = self.theme.rose-pine-moon.base09;
            inactive_border_color = self.theme.rose-pine-moon.base0D;

            color0 = self.theme.rose-pine-moon.base02;
            color8 = self.theme.rose-pine-moon.base03;

            color1 = self.theme.rose-pine-moon.base06;
            color9 = self.theme.rose-pine-moon.base06;

            color2 = self.theme.rose-pine-moon.base09;
            color10 = self.theme.rose-pine-moon.base09;

            color3 = self.theme.rose-pine-moon.base07;
            color11 = self.theme.rose-pine-moon.base07;

            color4 = self.theme.rose-pine-moon.base0A;
            color12 = self.theme.rose-pine-moon.base0A;

            color5 = self.theme.rose-pine-moon.base0B;
            color13 = self.theme.rose-pine-moon.base0B;

            color6 = self.theme.rose-pine-moon.base08;
            color14 = self.theme.rose-pine-moon.base08;

            color7 = self.theme.rose-pine-moon.base05;
            color15 = self.theme.rose-pine-moon.base05;
          };
        };
      };
    };
}
