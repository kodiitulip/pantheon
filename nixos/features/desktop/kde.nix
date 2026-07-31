{
  flake.nixosModules.kde =
    { pkgs, config, ... }:
    {
      services = {
        displayManager.sddm.enable = !config.programs.noctalia-greeter.enable;
        desktopManager.plasma6.enable = true;
      };
      security.rtkit.enable = true;
      environment.systemPackages = [ pkgs.kdePackages.kdeconnect-kde ];
      programs.kdeconnect.enable = true;
    };
}
