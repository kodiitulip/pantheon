{ inputs, ... }:
{
  flake.nixosModules.desktop =
    { pkgs, config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      imports = [ inputs.noctalia-greeter.nixosModules.default ];
      hardware.i2c.enable = true;
      security = {
        polkit = {
          enable = true;
          enablePkexecWrapper = true;
        };
        rtkit.enable = true;
      };
      services = {
        xserver.enable = true;
        pulseaudio.enable = false;
        gvfs.enable = true;
        gnome.gnome-keyring.enable = true;
        dbus.packages = with pkgs; [ nautilus ];
        pipewire = {
          enable = true;
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          jack.enable = true;
        };
        displayManager.noctalia-greeter = {
          enable = true;
          passwordless-sync-users = [
            "kodie"
            username
          ];
          settings = {
            cursor.size = 24;
            keyboard = {
              layout = "br";
              variant = "nodeadkeys";
              options = "compose:rctrl";
              numlock = true;
            };
            auth.allow_empty_passwords = false;
            appearance = {
              hide_logo = true;
              password_style = "random";
              scheme = "Synced";
              corner_radius_scale = 0.0;
              font_family = "Monocraft";
            };
          };
        };
      };
      xdg = {
        portal = {
          enable = true;
          extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
        };
        mime.defaultApplications = {
          "inode/directory" = [ "nemo.desktop" ];
          "application/x-gnome-saved-search" = [ "nemo.desktop" ];
        };
      };
      environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORMTHEME = "qt6ct";
        GTK_IM_MODULE = "simple";
      };
      environment.systemPackages = with pkgs; [
        # Misc Stuff
        nemo-with-extensions
        nwg-look
        adw-gtk3
        dconf-editor
        eog
        btop
        kdePackages.partitionmanager
        kdePackages.qt6ct

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
    };
}
