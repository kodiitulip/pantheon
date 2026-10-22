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
                #_R_G *:not([stroke="none"]) { stroke: var(--spice-button); }
                .main-addButton-button[aria-checked="false"] { color: rgba(var(--spice-rgb-selected-row), 0.7); }
                .control-button-heart[aria-checked="true"], .main-addButton-button, .main-addButton-active:focus, .main-addButton-active:hover { color: var(--spice-button); }
              ''
              ''
                .main-likedSongsButton-likedSongsIcon {
                  color: var(--spice-sidebar);
                  background: var(--spice-text);
                }
              ''
            ];
            theme = spicePkgs.themes.text // {
              additionalCSS = ''
                :root {
                  --font-family: "Monocraft", monospace;
                  --font-size: 14px;
                  --font-weight: 400; /* 200 : 900 */
                  --line-height: 1.2;

                  --font-size-lyrics: 14px; /* 1.5em (default) */

                  --font-family-header: "asciid";
                  --font-size-multiplier-header: 4;

                  --display-card-image: block; /* none | block */
                  --display-coverart-image: none; /* none | block */
                  --display-header-image: none; /* none | block */
                  --display-sidebar-image: block; /* none | block */
                  --display-tracklist-image: none; /* none | block */
                  --display-spicetify-banner-ascii: block; /* none | block */
                  --display-music-banner-ascii: block; /* none | block */

                  --border-radius: 0px;
                  --border-width: 2px;
                  --border-style: solid; /* dotted | dashed | solid | double | groove | ridge | inset | outset */
                  --border-transition: 0.2s ease; /* 'none' to disable  */

                  --global-nav-margin-top: 0px; /* set to '0px' if you disabled window controls */
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
