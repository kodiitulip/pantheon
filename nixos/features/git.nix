{
  flake.nixosModules.git =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        (self: super: {
          gh = super.gh.overrideAttrs rec {
            version = "2.95.0";
            src = super.fetchFromGitHub {
              owner = "cli";
              repo = "cli";
              tag = "v${version}";
              hash = "sha256-Hzdod8dJuwFv3mNa4Nflqf8uy45RpoeO93sFSMq3D5E=";
            };
            vendorHash = "sha256-tqbo791t7phe6ip5UzBiLer0rGcKqpKGF0bqwxr3j78=";
          };
        })
      ];
      environment.systemPackages = with pkgs; [ (gh) ];
      programs = {
        lazygit = {
          enable = true;
          settings = {
            os.openCommand = "sh -c \"xdg-open {{filename}} >/dev/null\"";
            os.openLink = "sh -c \"xdg-open {{link}} >/dev/null\"";
          };
        };
        git = {
          enable = true;
          package = pkgs.git.override { withLibsecret = true; };
          config = {
            credential.helper = "libsecret";
            push = {
              autoSetupRemote = true;
            };
            init = {
              defaultBranch = "main";
            };
            url = {
              "https://github.com/" = {
                insteadOf = [
                  "gh:"
                  "github:"
                ];
              };
            };
            user = {
              name = "kodiitulip";
              email = "kodii.tulip@proton.me";
            };
          };
        };
      };
    };
}
