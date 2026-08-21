{
  flake.nixosModules.desktop =
    { pkgs, ... }:
    {
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
        kdePackages.ark
        file-roller
      ];
      hardware.i2c.enable = true;
    };
}
