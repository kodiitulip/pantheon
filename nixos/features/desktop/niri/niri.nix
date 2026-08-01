{ self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, config, ... }:
    {
      environment.systemPackages = with pkgs; [
        xwayland-satellite # xwayland support
        nemo-with-extensions
        nautilus
        nwg-look
        adw-gtk3
        kdePackages.qt6ct
      ];
      environment.variables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };
      xdg = {
        portal = {
          enable = true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
          ]; # Fixes OpenURI and cursor themes in flatpaks
        };
        mime.defaultApplications = {
          "inode/directory" = [ "nemo.desktop" ];
          "application/x-gnome-saved-search" = [ "nemo.desktop" ];
        };
      };

      services.gvfs.enable = true;

      programs.niri.enable = true;
      hjem.users.${config.preferences.user.name} = {
        rum.desktops.niri = {
          enable = true;
          spawn-at-startup = [
            [ "noctalia" ]
          ];
          config = builtins.readFile ./niri.kdl + ''
            layout {
              gaps 8
              center-focused-column "never"
              preset-column-widths {
                  proportion 0.5
                  proportion 0.33333
                  proportion 0.66667
              }
              preset-window-heights {
                  proportion 0.5
                  proportion 1.0
              }
              default-column-width { proportion 1.0; }
              focus-ring { off; }
              shadow { off; }
              border {
                  on
                  width 4
                  inactive-color "${self.theme.rose-pine-dark.base03}"
                  urgent-color "${self.theme.rose-pine-dark.base06}"
              }
            }

            overview {
                backdrop-color "${self.theme.rose-pine-dark.base00}"
            }
          '';
          # nixfmt:disable
          binds = {
            "XF86AudioRaiseVolume".spawn = [
              "noctalia"
              "msg"
              "volume-up"
            ];
            "XF86AudioLowerVolume".spawn = [
              "noctalia"
              "msg"
              "volume-down"
            ];
            "XF86AudioMute".spawn = [
              "noctalia"
              "msg"
              "volume-mute"
            ];
            "XF86MonBrightnessUp".spawn = [
              "noctalia"
              "msg"
              "brightness-up"
            ];
            "XF86MonBrightnessDown".spawn = [
              "noctalia"
              "msg"
              "brightness-down"
            ];
            "XF86AudioPlay" = {
              parameters.allow-when-locked = true;
              spawn = [
                "noctalia"
                "msg"
                "media"
                "toggle"
              ];
            };
            "XF86AudioStop" = {
              parameters.allow-when-locked = true;
              spawn = [
                "noctalia"
                "msg"
                "media"
                "stop"
              ];
            };
            "XF86AudioPrev" = {
              parameters.allow-when-locked = true;
              spawn = [
                "noctalia"
                "msg"
                "media"
                "previous"
              ];
            };
            "XF86AudioNext" = {
              parameters.allow-when-locked = true;
              spawn = [
                "noctalia"
                "msg"
                "media"
                "next"
              ];
            };
            "XF86AudioMicMute" = {
              parameters.allow-when-locked = true;
              spawn = [
                "wpctl"
                "set-mute"
                "@DEFAULT_AUDIO_SOURCE@"
                "toggle"
              ];
            };

            "Mod+Space".spawn = [
              "noctalia"
              "msg"
              "panel-toggle"
              "launcher"
            ];
            "Mod+E".spawn = [ "nemo" ];
            "Mod+Shift+E".spawn = [
              "noctalia"
              "msg"
              "panel-open"
              "session"
            ];
            "Mod+Alt+L".spawn = [
              "noctalia"
              "msg"
              "session"
              "lock"
            ];

            "Mod+Tab" = {
              parameters.repeat = false;
              action = "toggle-overview";
            };
            "Mod+Q" = {
              parameters.repeat = false;
              action = "close-window";
            };

            "Mod+H".action = "focus-column-left";
            "Mod+J".action = "focus-window-or-workspace-down";
            "Mod+K".action = "focus-window-or-workspace-up";
            "Mod+L".action = "focus-column-right";
            "Mod+Left".action = "focus-column-left";
            "Mod+Down".action = "focus-window-or-workspace-down";
            "Mod+Up".action = "focus-window-or-workspace-up";
            "Mod+Right".action = "focus-column-right";
            "Mod+Shift+H".action = "move-column-left";
            "Mod+Shift+J".action = "move-window-down-or-to-workspace-down";
            "Mod+Shift+K".action = "move-window-up-or-to-workspace-up";
            "Mod+Shift+L".action = "move-column-right";
            "Mod+Shift+Left".action = "move-column-left";
            "Mod+Shift+Down".action = "move-window-down-or-to-workspace-down";
            "Mod+Shift+Up".action = "move-window-up-or-to-workspace-up";
            "Mod+Shift+Right".action = "move-column-right";
            "Mod+Page_Down".action = "focus-workspace-down";
            "Mod+Page_Up".action = "focus-workspace-up";
            "Mod+Shift+Page_Down".action = "move-column-to-workspace-down";
            "Mod+Shift+Page_Up".action = "move-column-to-workspace-up";
            "Mod+Ctrl+Page_Down".action = "move-workspace-down";
            "Mod+Ctrl+Page_Up".action = "move-workspace-up";
            "Mod+Home".action = "focus-column-first";
            "Mod+End".action = "focus-column-last";
            "Mod+Shift+Home".action = "move-column-to-first";
            "Mod+Shift+End".action = "move-column-to-last";
            "Mod+Ctrl+H".action = "focus-monitor-left";
            "Mod+Ctrl+J".action = "focus-monitor-down";
            "Mod+Ctrl+K".action = "focus-monitor-up";
            "Mod+Ctrl+L".action = "focus-monitor-right";
            "Mod+Ctrl+Left".action = "focus-monitor-left";
            "Mod+Ctrl+Down".action = "focus-monitor-down";
            "Mod+Ctrl+Up".action = "focus-monitor-up";
            "Mod+Ctrl+Right".action = "focus-monitor-right";
            "Mod+Shift+Ctrl+H".action = "move-column-to-monitor-left";
            "Mod+Shift+Ctrl+J".action = "move-column-to-monitor-down";
            "Mod+Shift+Ctrl+K".action = "move-column-to-monitor-up";
            "Mod+Shift+Ctrl+L".action = "move-column-to-monitor-right";
            "Mod+Shift+Ctrl+Left".action = "move-column-to-monitor-left";
            "Mod+Shift+Ctrl+Down".action = "move-column-to-monitor-down";
            "Mod+Shift+Ctrl+Up".action = "move-column-to-monitor-up";
            "Mod+Shift+Ctrl+Right".action = "move-column-to-monitor-right";

            "Mod+WheelScrollDown" = {
              parameters.cooldown-ms = 100;
              action = "focus-workspace-down";
            };
            "Mod+WheelScrollUp" = {
              parameters.cooldown-ms = 100;
              action = "focus-workspace-up";
            };
            "Mod+Ctrl+WheelScrollDown" = {
              parameters.cooldown-ms = 100;
              action = "move-column-to-workspace-down";
            };
            "Mod+Ctrl+WheelScrollUp" = {
              parameters.cooldown-ms = 100;
              action = "move-column-to-workspace-up";
            };
            "Mod+Shift+WheelScrollDown".action = "focus-column-right";
            "Mod+Shift+WheelScrollUp".action = "focus-column-left";
            "Mod+Ctrl+Shift+WheelScrollDown".action = "move-column-right";
            "Mod+Ctrl+Shift+WheelScrollUp".action = "move-column-left";

            "Mod+BracketLeft".action = "consume-or-expel-window-left";
            "Mod+BracketRight".action = "consume-or-expel-window-right";
            "Mod+Comma".action = "consume-window-into-column";
            "Mod+Period".action = "expel-window-from-column";

            "Mod+R".action = "switch-preset-column-width";
            "Mod+Shift+R".action = "switch-preset-column-width-back";
            "Mod+Ctrl+Shift+R".action = "switch-preset-window-height";
            "Mod+Ctrl+R".action = "reset-window-height";
            "Mod+F".action = "fullscreen-window";
            "Mod+Shift+F".action = "maximize-column";
            "Ctrl+Alt+F".action = "maximize-window-to-edges";
            "Mod+Ctrl+F".action = "expand-column-to-available-width";

            "Mod+C".action = "center-column";
            "Mod+Ctrl+C".action = "center-visible-columns";
            "Mod+S".action = "toggle-window-floating";
            "Mod+Shift+S".action = "switch-focus-between-floating-and-tiling";
            "Mod+Minus".action = ''set-column-width "-10%"'';
            "Mod+Equal".action = ''set-column-width "+10%"'';
            "Mod+Shift+Minus".action = ''set-window-height "-10%"'';
            "Mod+Shift+Equal".action = ''set-window-height "+10%"'';

            "Mod+W".action = "toggle-column-tabbed-display";
            "Mod+1".action = "focus-workspace 1";
            "Mod+2".action = "focus-workspace 2";
            "Mod+3".action = "focus-workspace 3";
            "Mod+4".action = "focus-workspace 4";
            "Mod+5".action = "focus-workspace 5";
            "Mod+6".action = "focus-workspace 6";
            "Mod+7".action = "focus-workspace 7";
            "Mod+8".action = "focus-workspace 8";
            "Mod+9".action = "focus-workspace 9";
            "Mod+Shift+1".action = "move-window-to-workspace 1";
            "Mod+Shift+2".action = "move-window-to-workspace 2";
            "Mod+Shift+3".action = "move-window-to-workspace 3";
            "Mod+Shift+4".action = "move-window-to-workspace 4";
            "Mod+Shift+5".action = "move-window-to-workspace 5";
            "Mod+Shift+6".action = "move-window-to-workspace 6";
            "Mod+Shift+7".action = "move-window-to-workspace 7";
            "Mod+Shift+8".action = "move-window-to-workspace 8";
            "Mod+Shift+9".action = "move-window-to-workspace 9";
            "Mod+Ctrl+1".action = "move-column-to-workspace 1";
            "Mod+Ctrl+2".action = "move-column-to-workspace 2";
            "Mod+Ctrl+3".action = "move-column-to-workspace 3";
            "Mod+Ctrl+4".action = "move-column-to-workspace 4";
            "Mod+Ctrl+5".action = "move-column-to-workspace 5";
            "Mod+Ctrl+6".action = "move-column-to-workspace 6";
            "Mod+Ctrl+7".action = "move-column-to-workspace 7";
            "Mod+Ctrl+8".action = "move-column-to-workspace 8";
            "Mod+Ctrl+9".action = "move-column-to-workspace 9";

            "Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Shift+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Ctrl+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Ctrl+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Shift+Ctrl+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Shift+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Shift+Ctrl+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Ctrl+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Shift+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Ctrl+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Shift+Ctrl+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Shift+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];
            "Mod+Shift+Ctrl+Alt+Print".spawn = [
              "noctalia"
              "msg"
              "screenshot-region"
            ];

            "Mod+Escape" = {
              parameters.allow-inhibiting = false;
              action = "toggle-keyboard-shortcuts-inhibit";
            };
            "Mod+Return".spawn = [ "kitty" ];
            # nixfmt:enable
          };
        };
      };
      services.gnome.gnome-keyring.enable = true;
      security.polkit.enable = true;
    };
}
