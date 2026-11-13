{ ... }:
{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    let
      name = config.preferences.user.name;
    in
    {
      hjem.users.${name}.packages = with pkgs; [
        pear-desktop
        spicetify-cli
      ];

      services.flatpak.packages = [
        {
          appId = "com.spotify.Client";
          origin = "flathub";
        }
      ];
    };
}
