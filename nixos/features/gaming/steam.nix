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
        extraPackages = with pkgs; [
          gamescope
          hidapi
        ];
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        steam-art-manager
        protonup-qt
      ];
    };
}
