{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.zen = (
        pkgs.wrapFirefox
          inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.zen-browser-unwrapped
          {
            nativeMessagingHosts = [ pkgs.firefoxpwa ];
            extraPolicies = {
              DisableTelemetry = true;
              SearchEngines = {
                Default = "ddg";
                Add = [
                  {
                    Name = "NixOS packages";
                    URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@np";
                  }
                  {
                    Name = "NixOS Wiki";
                    URLTemplate = "https://wiki.nixos.org/w/index.php?search={searchTerms}";
                    IconURL = "https://wiki.nixos.org/favicon.ico";
                    Alias = "@nw";
                  }
                  {
                    Name = "Noogle";
                    URLTemplate = "https://noogle.dev/q?term={searchTerms}";
                    IconURL = "https://noogle.dev/favicon.ico";
                    Alias = "@ng";
                  }
                  {
                    Name = "Modrinth Mods";
                    URLTemplate = "https://modrinth.com/discover/mods?q={searchTerms}";
                    IconURL = "https://modrinth.com/favicon.ico";
                    Alias = "@mods";
                  }
                  {
                    Name = "Github Search";
                    URLTemplate = "https://github.com/search?q={searchTerms}&type=repositories";
                    IconURL = "https://github.com/favicon.ico";
                    Alias = "@gh";
                  }
                ];
              };
            };
          }
      );
    };
}
