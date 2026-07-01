{ self, ... }:
{
    flake.nixosModules.kde =
    { pkgs, ... }:
    {
        imports = [ self.nixosModules.desktop ];
        services = {
            displayManager.sddm.enable = true;
            desktopManager.plasma6.enable = true;
        };
        security.rtkit.enable = true;
    };
}
