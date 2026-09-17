{ self, inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, config, ... }:
    {
      imports = [ inputs.noctalia-greeter.nixosModules.default ];
      services = {
        xserver.enable = true;
        pulseaudio.enable = false;
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };

        displayManager.noctalia-greeter = {
          enable = true;
          greeter-args = "";
          settings = {
            cursor = {
              theme = "BreezeX-RosePine-Linux";
              size = 24;
              path = "${pkgs.rose-pine-cursor}/share/icons";
            };
            keyboard = {
              layout = "br";
              variant = "nodeadkeys";
              options = "compose:rctrl";
              numlock = true;
            };
            session.default = "niri";
            user.default = config.preferences.user.name;
            auth.allow_empty_passwords = false;
            appearance = {
              hide_logo = true;
              password_style = "random";
              scheme = "Synced";
              corner_radius_scale = 0.0;
              font_family = "Monocraft";
              wallpaper = {
                path = "color:${self.theme.rose-pine-dark.base00}";
                fill_mode = "crop";
                fill_color = self.theme.rose-pine-dark.base00;
              };
            };
          };
        };
      };

      security.rtkit.enable = true;
      environment.sessionVariables.NIXOS_OZONE_WL = "1";
      environment.systemPackages = with pkgs; [
        kdePackages.partitionmanager
        vlc
        pwvucontrol
        ddcutil
        libnotify

        # CLI File Archivers
        zip
        unzip
        libarchive
        unrar-free

        # GUI File Archivers
        peazip
        file-roller
      ];
      hardware.i2c.enable = true;
    };
}
