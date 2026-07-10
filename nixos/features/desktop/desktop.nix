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
        rar
        kdePackages.partitionmanager
        vlc
      ];
    };
}
