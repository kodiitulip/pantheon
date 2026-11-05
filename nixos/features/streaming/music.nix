{ inputs, ... }:
{
  flake.nixosModules.music =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      spicePkgs = inputs.spicetify-nix.legacyPackages.${system};
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
            wayland = true;
            enabledCustomApps = with spicePkgs.apps; [
              marketplace
              lyricsPlus
            ];
            enabledSnippets = [
              ''
                #_R_G *:not([fill="none"]) { fill: var(--spice-button) !important; }
                #_R_G *:not([stroke="none"]) { stroke: var(--spice-button) !important; }
                .main-addButton-button[aria-checked="false"] { color: rgba(var(--spice-rgb-selected-row), 0.7) !important; }
                .control-button-heart[aria-checked="true"], .main-addButton-button, .main-addButton-active:focus, .main-addButton-active:hover { color: var(--spice-button) !important; }
              ''
              ''
                .main-likedSongsButton-likedSongsIcon {
                  color: var(--spice-sidebar) !important;
                  background: var(--spice-text) !important;
                }
              ''
            ];
            theme = spicePkgs.themes.text // {
              additionalCSS = ''
                :root {
                  --font-family: "Monocraft", monospace !important;
                  --font-size: 14px !important;
                  --font-weight: 400 !important;
                  --line-height: 1.2 !important;

                  --font-size-lyrics: 14px !important;

                  --font-family-header: "asciid" !important;
                  --font-size-multiplier-header: 4 !important;

                  --display-card-image: block !important;
                  --display-coverart-image: none !important;
                  --display-header-image: none !important;
                  --display-sidebar-image: block !important;
                  --display-tracklist-image: none !important;
                  --display-spicetify-banner-ascii: block !important;
                  --display-music-banner-ascii: block !important;

                  --border-radius: 0px !important;
                  --border-width: 2px !important;
                  --border-style: solid !important;
                  --border-transition: 0.2s ease !important;

                  --global-nav-margin-top: 0px !important;
                }
              '';
            };
            colorScheme = "Spotify";
          };
          packages = with pkgs; [
            pear-desktop
          ];
        };
      };
    };
}
