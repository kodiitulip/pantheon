{ inputs, ... }:
{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [ inputs.spicetify-nix.nixosModules.spicetify ];

      hjem.users.${config.preferences.user.name}.packages = with pkgs; [ pear-desktop ];

      programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
          shuffle
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
