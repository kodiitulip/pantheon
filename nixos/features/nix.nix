{
  flake.nixosModules.nix =
    { pkgs, config, ... }:
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
      };

      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
        };
        optimise.automatic = true;
      };
      nixpkgs.config.allowUnfree = true;
      hjem.users.${config.preferences.user.name} = {
        xdg.config.files."direnv/direnv.toml".source = (pkgs.formats.toml { }).generate "direnv.toml" {
          global = {
            warn_timeout = "0s";
            hide_env_diff = true;
          };
        };
        rum.programs.nix-your-shell = {
          integrations.nushell.enable = true;
          enable = true;
        };
      };

      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep 3 --keep-since 3d";
        };
        flake = "/home/kodie/pantheon";
      };

      environment.systemPackages = with pkgs; [
        nil
        nixd
        statix
        alejandra
        manix
        nix-inspect
      ];
    };
}
