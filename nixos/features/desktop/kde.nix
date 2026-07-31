{
  flake.nixosModules.kde =
    { pkgs, ... }:
    {
      services = {
        displayManager.sddm.enable = true;
        desktopManager.plasma6.enable = true;
      };
      security.rtkit.enable = true;
      environment.systemPackages = [ pkgs.kdePackages.kdeconnect-kde ];
      programs.kdeconnect.enable = true;
    };
}
