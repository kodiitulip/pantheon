{
    flake.nixosModules.gaming =
    { pkgs, ... }:
    {
        programs.steam = {
            enable = true;
            extest.enable = true;
            protontricks.enable = true;
            remotePlay.openFirewall = true;
            localNetworkGameTransfers.openFirewall = true;
        };
    };
}
