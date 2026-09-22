{
  flake.nixosModules.nix =
    { pkgs, config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      programs = {
        direnv = {
          enable = true;
          silent = true;
          loadInNixShell = true;
          direnvrcExtra = "";
          nix-direnv.enable = true;
        };
        nix-ld.enable = true;
        nix-index.enable = true;
      };

      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          trusted-users = [
            "kodie"
            username
          ];
        };
        optimise.automatic = true;
      };
      nixpkgs.config.allowUnfree = true;
      hjem.users.${username} = {
        xdg.config.files."direnv/direnv.toml".source = (pkgs.formats.toml { }).generate "direnv.toml" {
          global = {
            warn_timeout = "-1s";
            hide_env_diff = true;
            load_dotenv = true;
            strict_env = true;
          };
        };
        rum.programs.nix-your-shell = {
          integrations.nushell.enable = true;
          enable = true;
        };
      };

      programs.nh = {
        enable = true;
        flake = "/home/kodie/pantheon";
      };

      environment.systemPackages = with pkgs; [
        nil
        nixd
        statix
        alejandra
        manix
        nix-inspect
        nixfmt
        cachix
      ];
    };
}
