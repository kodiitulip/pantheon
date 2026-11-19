{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone =
    { pkgs, config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      imports = with self.nixosModules; [
        base
        console

        nix
        git

        desktop
        umbriel
        niri

        gaming

        obs-studio
        music
        art
      ];

      networking.hostName = "persephone";
      services = {
        hardware.openrgb = {
          enable = true;
          package = pkgs.openrgb-with-all-plugins;
          motherboard = "amd";
        };
        postgresql = {
          enable = true;
          authentication = pkgs.lib.mkOverride 10 ''
            #type database DBuser origin-address auth-method
            local all      all     trust
            # ipv4
            host  all      all     127.0.0.1/32  trust
            # ipv6
            host  all      all     ::1/128       trust
          '';
          enableTCPIP = true;
          # port = 5432;
          ensureUsers = [
            {
              name = username;
            }
          ];
        };
      };

      preferences.user = {
        enable = true;
        enableHjemUser = true;
        name = "kodie";
        face = ./avatar.png;
      };

      hjem.users.${username}.rum.programs.git = {
        enable = true;
        settings.user = {
          email = "kodii.tulip@proton.me";
          name = "kodiitulip";
        };
        ignore = ''
          .direnv
          result*
        '';
      };

      programs = {
        firefox.enable = true;
      };

      hardware.uinput.enable = true;
      hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
        settings = {
          General = {
            Privacy = "device";
            JustWorksRepairing = "always";
            Class = "0x000100";
            FastConnectable = true;
            Experimental = true;
          };
        };
      };
      hardware.xpadneo.enable = true;

      boot.kernelModules = [ "uinput" ];

      nixpkgs.config.allowUnfree = true;

      system.stateVersion = "26.05"; # WARN: No changing wili nilly
    };
}
