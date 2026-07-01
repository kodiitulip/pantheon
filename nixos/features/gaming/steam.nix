{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      programs.steam = {
        enable = true;
        extest.enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      hjem.users.${config.preferences.user.name}.packages = [ pkgs.steam-art-manager ];
    };
}
