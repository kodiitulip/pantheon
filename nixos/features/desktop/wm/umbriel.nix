{ self, inputs, ... }:
{
  flake.nixosModules.umbriel =
    { pkgs, config, ... }:
    let
      pkgs' = self.packages.${pkgs.stdenv.hostPlatform.system};
      username = config.preferences.user.name;
    in
    {
      imports = [ inputs.umbriel.nixosModules.default ];
      programs.umbriel.enable = true;

      hjem.extraModules = [ inputs.umbriel.hjemModules.default ];
      hjem.users.${username}.programs.umbriel = {
        enable = true;
        settings = {
          include.optional.files = [
            "noctalia.toml"
            "umbriel.toml"
          ];

          general = {
            autostart = [ "noctalia" ];
            xwayland_native_resolution = true;
          };

          appearance = {
            prefer_no_csd = true;
            border_width = 2;
            outer_border_width = 0;
            corner_radius = 0;
            drag_opacity = 0.75;
            opaque_fullscreen = true;

            blur.radius = 3;
            tab_bar = {
              style = "indicator";
              height = 8;
              font = "Minecraftia 10";
              visible = true;
              hide_when_single = false;
              max_tabs = 6;
              overflow = "scroll";
            };
          };

          input = {
            middle_click_paste = false;
            window_drag_toggle = "floating";

            keyboard = {
              layout = "br";
              variant = "nodeadkeys";
              options = "compose:rctrl";
              numlock_toggle = true;
            };

            cursor = {
              follows_focus = true;
              hide_when_typing = true;
              hide_timeout_ms = 10000;
            };

            drag_edge_scroll = {
              enabled = true;
              trigger_zone = 30;
              delay_ms = 100;
              max_speed = 1500.0;
            };

            focus.follows_mouse = false;
          };

          hot_corners.top_left = {
            enabled = true;
            delay_ms = 500;
            action = "overview-open";
          };

          layout = {
            gap = 4;
            extent_presets = [
              0.333
              0.5
              0.667
            ];

            tabs = {
              default_display = "normal";
              new_tab_position = "after_active";
              middle_click_closes = true;
            };
          };
        };

        keybinds = {
          # Media
          "XF86AudioRaiseVolume" = "spawn:noctalia msg volume-up";
          "XF86AudioLowerVolume" = "spawn:noctalia msg volume-down";
          "XF86AudioMute" = "spawn:noctalia msg volume-mute";
          "XF86AudioMicMute" = "spawn:noctalia msg mic-mute";
          "XF86AudioPlay" = "spawn:noctalia msg media toggle";
          "XF86AudioStop" = "spawn:noctalia msg media stop";
          "XF86AudioPrev" = "spawn:noctalia msg media previous";
          "XF86AudioNext" = "spawn:noctalia msg media next";
          "XF86MonBrightnessUp" = "spawn:noctalia msg brightness-up";
          "XF86MonBrightnessDown" = "spawn:noctalia msg brightness-down";

          # Session/System
          "Mod+Shift+E" = "spawn:noctalia msg panel-toggle session";
          "Mod+Alt+L" = "spawn:noctalia msg session lock";
          "Mod+Tab" = {
            action = "overview-toggle";
            repeat = false;
          };
          "Mod+Shift+Question" = "cheatsheet-toggle";
          "Mod+Shift+Alt+R" = {
            action = "config-reload";
            repeat = false;
          };
          "Mod+Shift+Escape" = {
            action = "shortcuts-inhibit-toggle";
            allow_when_inhibited = true;
            repeat = false;
          };
          "Mod+V" = {
            action = "spawn:noctalia msg panel-toggle clipboard";
            repeat = false;
          };
          "Print" = {
            action = "spawn:noctalia msg screenshot-region";
            repeat = false;
          };
          "Mod+Shift+Delete" = {
            action = "scratchpad-toggle:monitor";
            repeat = false;
          };
          "Mod+Shift+M" = {
            action = "scratchpad-toggle:music";
            repeat = false;
          };
          "Mod+Shift+W" = {
            action = "spawn:noctalia msg panel-toggle wallpaper";
            repeat = false;
          };

          # Apps
          "Mod+Q" = "window-close";
          "Mod+Space" = "spawn:noctalia msg panel-toggle launcher";
          "Mod+E" = {
            action = "spawn:nemo";
            repeat = false;
          };
          "Mod+Alt+Return" = {
            action = ''spawn:kitty --class="kitty-floating"'';
            repeat = false;
          };
          "Mod+Return" = {
            action = "spawn:kitty";
            repeat = false;
          };

          # Screencast
          "Mod+F11" = "screencast-set-window";
          "Mod+Alt+F11" = "screencast-set-output";
          "Mod+Shift+F11" = "screencast-clear";

          # Window Focus
          "Mod+Backspace" = "window-focus-last";
          "Mod+BracketLeft" = "window-focus-previous";
          "Mod+BracketRight" = "window-focus-next";
          "Mod+H" = "window-focus-left";
          "Mod+J" = "window-focus-or-workspace-down";
          "Mod+K" = "window-focus-or-workspace-up";
          "Mod+L" = "window-focus-right";
          "Mod+Left" = "window-focus-left";
          "Mod+Down" = "window-focus-or-workspace-down";
          "Mod+Up" = "window-focus-or-workspace-up";
          "Mod+Right" = "window-focus-right";
          "Mod+Shift+WheelDown" = "window-focus-right";
          "Mod+Shift+WheelUp" = "window-focus-left";

          # Window State
          "Mod+S" = {
            action = "window-toggle-floating";
            repeat = false;
          };
          "Mod+Shift+S" = {
            action = "window-focus-switch-floating";
            repeat = false;
          };
          "Mod+P" = {
            action = "window-toggle-pinned";
            repeat = false;
          };
          "Ctrl+Alt+F" = {
            action = "window-toggle-maximize-to-edges";
            repeat = false;
          };
          "Mod+Shift+F" = {
            action = "window-toggle-fullscreen";
            repeat = false;
          };
          "Mod+F" = {
            action = "window-toggle-maximize";
            repeat = false;
          };
          "Mod+W" = {
            action = "column-toggle-tabbed";
            repeat = false;
          };
          "Mod+R" = "window-cycle-primary-extent";
          "Mod+Shift+R" = "window-cycle-primary-extent-back";
          "Mod+Equal" = "window-modify-width-right:0.1";
          "Mod+Minus" = "window-modify-width-right:-0.1";
          "Mod+Shift+Equal" = "window-modify-height-down:0.1";
          "Mod+Shift+Minus" = "window-modify-height-down:-0.1";

          # Window Movement
          "Mod+Shift+J" = "window-move-or-workspace-down";
          "Mod+Shift+K" = "window-move-or-workspace-up";
          "Mod+Shift+Down" = "window-move-or-workspace-down";
          "Mod+Shift+Up" = "window-move-or-workspace-up";
          "Mod+Shift+Ctrl+WheelDown" = "window-move-or-workspace-down";
          "Mod+Shift+Ctrl+WheelUp" = "window-move-or-workspace-up";
          "Mod+Comma" = "window-consume-left";
          "Mod+Period" = "window-consume-right";
          "Mod+Shift+Comma" = "window-consume-from-left";
          "Mod+Shift+Period" = "window-consume-from-right";
          "Mod+Alt+Comma" = "window-consume-or-expel-left";
          "Mod+Alt+Period" = "window-consume-or-expel-right";
          "Mod+Shift+1" = "window-move-to-workspace:1";
          "Mod+Shift+2" = "window-move-to-workspace:2";
          "Mod+Shift+3" = "window-move-to-workspace:3";
          "Mod+Shift+4" = "window-move-to-workspace:4";
          "Mod+Shift+5" = "window-move-to-workspace:5";
          "Mod+Shift+6" = "window-move-to-workspace:6";
          "Mod+Shift+7" = "window-move-to-workspace:7";
          "Mod+Shift+8" = "window-move-to-workspace:8";
          "Mod+Shift+9" = "window-move-to-workspace:9";

          # Column Focus
          "Mod+Home" = "column-focus-first";
          "Mod+End" = "column-focus-last";
          "Mod+Alt+BracketLeft" = "column-focus-tab-previous";
          "Mod+Alt+BracketRight" = "column-focus-tab-next";

          # Column Movement
          "Mod+C" = "column-center";
          "Mod+Shift+H" = "column-move-left";
          "Mod+Shift+L" = "column-move-right";
          "Mod+Shift+Left" = "column-move-left";
          "Mod+Shift+Right" = "column-move-right";
          "Mod+Alt+Shift+WheelDown" = "column-move-right";
          "Mod+Alt+Shift+WheelUp" = "column-move-left";
          "Mod+Alt+Shift+J" = "column-move-to-workspace-next";
          "Mod+Alt+Shift+K" = "column-move-to-workspace-previous";
          "Mod+Alt+Shift+Down" = "column-move-to-workspace-next";
          "Mod+Alt+Shift+Up" = "column-move-to-workspace-previous";
          "Mod+Ctrl+1" = "column-move-to-workspace:1";
          "Mod+Ctrl+2" = "column-move-to-workspace:2";
          "Mod+Ctrl+3" = "column-move-to-workspace:3";
          "Mod+Ctrl+4" = "column-move-to-workspace:4";
          "Mod+Ctrl+5" = "column-move-to-workspace:5";
          "Mod+Ctrl+6" = "column-move-to-workspace:6";
          "Mod+Ctrl+7" = "column-move-to-workspace:7";
          "Mod+Ctrl+8" = "column-move-to-workspace:8";
          "Mod+Ctrl+9" = "column-move-to-workspace:9";

          # Output Focus
          "Mod+Ctrl+BracketLeft" = "output-focus-previous";
          "Mod+Ctrl+BracketRight" = "output-focus-next";
          "Mod+Ctrl+H" = "output-focus-left";
          "Mod+Ctrl+J" = "output-focus-down";
          "Mod+Ctrl+K" = "output-focus-up";
          "Mod+Ctrl+L" = "output-focus-right";
          "Mod+Ctrl+Left" = "output-focus-left";
          "Mod+Ctrl+Down" = "output-focus-down";
          "Mod+Ctrl+Up" = "output-focus-up";
          "Mod+Ctrl+Right" = "output-focus-right";

          # Workspace Focus
          "Mod+Page_Down" = "workspace-next";
          "Mod+Page_Up" = "workspace-previous";
          "Mod+Shift+Backspace" = "workspace-focus-last";
          "Mod+WheelUp" = "workspace-previous";
          "Mod+WheelDown" = "workspace-next";
          "Mod+1" = "workspace-switch:1";
          "Mod+2" = "workspace-switch:2";
          "Mod+3" = "workspace-switch:3";
          "Mod+4" = "workspace-switch:4";
          "Mod+5" = "workspace-switch:5";
          "Mod+6" = "workspace-switch:6";
          "Mod+7" = "workspace-switch:7";
          "Mod+8" = "workspace-switch:8";
          "Mod+9" = "workspace-switch:9";

          # Workspace Movement
          "Mod+Shift+Page_Down" = "workspace-move-down";
          "Mod+Shift+Page_Up" = "workspace-move-up";
        };

        layer_rule = [
          {
            match.namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd|desktop-widget-[^\"]*)$";
            blur = true;
            blur_ignore_alpha = 0.5;
            blur_popups = true;
            blur_optimized = true;
          }
        ];

        window_rule = [
          {
            blur = true;
            blur_optimized = true;
          }
          {
            match.is_alone = true;
            default_maximize = true;
          }
          {
            match.title = "^notificationtoasts_.+_desktop";
            default_position = {
              x = 2;
              y = 2;
              anchor = "bottom_right";
            };
            default_focused = false;
            default_pinned = true;
          }
          {
            match.app_id = [
              "^steam_app_"
              "[mM]inecraft"
            ];
            default_output = "sunshine";
            default_workspace = 5;
          }
          {
            match.app_id = "^steam$";
            match.title = "[Bb]ig [Pp]icture";
            default_output = "sunshine";
            default_fullscreen = true;
          }
          {
            match.title = "^(Picture-in-Picture|Picture in picture)$";
            default_floating = true;
            default_maximize = false;
            default_focused = false;
            default_position = {
              x = 2;
              y = 2;
              anchor = "top_right";
            };
          }
          {
            match.app_id = "^dev.zed.Zed$";
            match.title = "[Ss]ettings";
            default_floating = true;
            default_floating_size = {
              width = 0.5;
              height = 0.5;
            };
          }
          {
            match.app_id = "^dev.noctalia.UmbrielSharePicker$";
            default_floating = true;
            default_floating_size = {
              width = 0.25;
              height = 0.5;
            };
          }
          {
            match.app_id = [
              "floating"
              "nemo"
              "xdg-desktop-portal-gtk"
              "^dev.noctalia.Noctalia$"
              "^org.gnome.FileRoller$"
              "pwvucontrol"
              "[nN]autilus"
              "g[tT]humb"
            ];
            default_floating = true;
            default_floating_size = {
              width = 0.75;
              height = 0.75;
            };
          }
          {
            match.app_id = "spotify";
            default_scratchpad = "music";
          }
          {
            match.app_id = "^zen$";
            default_workspace = 1;
          }
          {
            match.content_type = "photo";
            default_floating = true;
          }
          {
            match.app_id = "^kitty-btop$";
            default_scratchpad = "monitor";
            default_floating_size = {
              width = 0.75;
              height = 0.75;
            };
          }
          {

            match.app_id = "^packweave$";
            match.title = "Settings";
            default_floating = true;
          }
        ];

        scratchpad = [
          {
            name = "music";
            spawn_when_empty = "spotify";
          }
          {
            name = "monitor";
            spawn_when_empty = "kitty --class=\"kitty-btop\" btop";
          }
        ];
      };

      environment.systemPackages =
        with pkgs;
        with pkgs';
        [
          xwayland
          playerctl
          brightnessctl
        ];
    };
}
