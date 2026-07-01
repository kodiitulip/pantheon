{
  flake.nixosModules.git =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ github-cli ];
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
          config = {
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
