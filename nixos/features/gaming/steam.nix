{ inputs, ... }:
{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      nixpkgs.overlays = [ inputs.millennium.overlays.default ];
      programs.gamemode.enable = true;
      programs.steam = {
        enable = true;
        package = pkgs.millennium-steam;
        extest.enable = true;
        protontricks.enable = true;
        remotePlay.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
      };
      hjem.users.${config.preferences.user.name}.packages = [ pkgs.steam-art-manager ];
    };
}
