{
  flake.nixosModules.kde =
    { pkgs, ... }:
    {
      services.desktopManager.plasma6.enable = true;
      security.rtkit.enable = true;
      environment.systemPackages = [ pkgs.kdePackages.kdeconnect-kde ];
      programs.kdeconnect.enable = true;
    };
}
