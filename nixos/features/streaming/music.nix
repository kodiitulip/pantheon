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
          shuffle
          history
          allOfArtist
          {
            src = pkgs.fetchFromGitHub {
              owner = "ohitstom";
              repo = "spicetify-extensions";
              rev = "3cbfae12b79871fa0b79b7a9a0ef79dcce18875b";
              hash = "sha256-1fPCUcaTTmxGWmiPfq6mJDzMJ85IK1RovMOfCp2Jfew=";
            };
            name = "pixelatedImages/pixelatedImages.js";
          }
        ];
        theme = spicePkgs.themes.text;
        colorScheme = "RosePineMoon";
      };
    };
}
