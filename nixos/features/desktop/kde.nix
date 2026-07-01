{ self, ... }:
{
  flake.nixosModules.kde = {
    imports = [ self.nixosModules.desktop ];
    services = {
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
    security.rtkit.enable = true;
  };
}
