{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        pear-desktop
        spotify
        spicetify-cli
      ];
    };
}
