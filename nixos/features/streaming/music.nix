{ inputs, ... }:
{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [ inputs.spicetify-nix.nixosModules.spicetify ];

      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        pear-desktop
        config.programs.spicetify.spicedSpotify
      ];

      programs.spicetify = {
        enable = false;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
          shuffle
          fullAppDisplay
          keyboardShortcut
          spicyLyrics
        ];
        theme = spicePkgs.themes.text // {
          additionalCss = ''
            --font-family: 'Fira Code', monospace;
          '';
        };
        colorScheme = "RosePineMoon";
      };
    };
}
