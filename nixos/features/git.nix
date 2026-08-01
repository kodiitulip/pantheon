{
  flake.nixosModules.git =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ gh ];
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
            credential = {
              "https://github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential get";
              "https://gist.github.com".helper = "!${pkgs.gh}/bin/gh auth git-credential get";
            };
            push.autoSetupRemote = true;
            pull.rebase = true;
            init.defaultBranch = "main";
            url."https://github.com/".insteadOf = [
              "gh:"
              "github:"
            ];
            user = {
              name = "kodiitulip";
              email = "kodii.tulip@proton.me";
            };
          };
        };
      };
    };
}
