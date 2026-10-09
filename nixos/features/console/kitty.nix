{ ... }:
{
  flake.nixosModules.console =
    { pkgs, config, ... }:
    let
      inherit (pkgs.lib) getExe;
      username = config.preferences.user.name;
    in
    {
      environment.systemPackages = [ pkgs.kitty ];
      fonts.packages = with pkgs; [
        nerd-fonts.caskaydia-cove
        nerd-fonts.symbols-only
        monocraft
        minecraftia
      ];
      hjem.users.${username}.rum.programs.kitty = {
        enable = true;
        settings = {
          include = "~/.config/kitty/themes/noctalia.conf";
          enable_audio_bell = "no";
          shell = getExe pkgs.nushell;

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

          symbol_map = [
            # "Nerd Fonts - Pomicons"
            "U+E000-U+E00D Symbols Nerd Font Mono"
            # "Nerd Fonts - Powerline"
            "U+e0a0-U+e0a2,U+e0b0-U+e0b3 Symbols Nerd Font Mono"
            # "Nerd Fonts - Powerline Extra"
            "U+e0a3-U+e0a3,U+e0b4-U+e0c8,U+e0cc-U+e0d2,U+e0d4-U+e0d4 Symbols Nerd Font Mono"
            # "Nerd Fonts - Symbols original"
            "U+e5fa-U+e62b Symbols Nerd Font Mono"
            # "Nerd Fonts - Devicons"
            "U+e700-U+e7c5 Symbols Nerd Font Mono"
            # "Nerd Fonts - Font awesome"
            "U+f000-U+f2e0 Symbols Nerd Font Mono"
            # "Nerd Fonts - Font awesome extension"
            "U+e200-U+e2a9 Symbols Nerd Font Mono"
            # "Nerd Fonts - Octicons"
            "U+f400-U+f4a8,U+2665-U+2665,U+26A1-U+26A1,U+f27c-U+f27c Symbols Nerd Font Mono"
            # "Nerd Fonts - Font Linux"
            "U+F300-U+F313 Symbols Nerd Font Mono"
            #  Nerd Fonts - Font Power Symbols"
            "U+23fb-U+23fe,U+2b58-U+2b58 Symbols Nerd Font Mono"
            #  "Nerd Fonts - Material Design Icons"
            "U+f500-U+fd46 Symbols Nerd Font Mono"
            # "Nerd Fonts - Weather Icons"
            "U+e300-U+e3eb Symbols Nerd Font Mono"
            # Misc Code Point Fixes
            "U+21B5,U+25B8,U+2605,U+2630,U+2632,U+2714,U+E0A3,U+E615,U+E62B Symbols Nerd Font Mono"
          ];
        };
      };
    };
}
