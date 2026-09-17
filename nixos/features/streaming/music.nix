{ inputs, ... }:
{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
      username = config.preferences.user.name;
    in
    {
      hjem = {
        extraModules = [ inputs.spicetify-nix.hjemModules.default ];
        users.${username} = {
          programs.spicetify = {
            enable = true;
            enabledExtensions = with spicePkgs.extensions; [
              adblockify
              shuffle
              history
              {
                src = ./tuna-spicetify;
                name = "tunaSpicetify.js";
              }
            ];
            enabledCustomApps = with spicePkgs.apps; [
              marketplace
              lyricsPlus
            ];
            enabledSnippets = [ ];
            theme = spicePkgs.themes.text;
            colorScheme = "RosePineMoon";
          };
          packages = with pkgs; [
            pear-desktop
          ];
        };
      };
    };
}
