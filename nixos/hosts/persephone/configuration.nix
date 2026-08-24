{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone =
    { lib, config, ... }:
    {
      imports = with self.nixosModules; [
        base
        console

        nix
        git

        desktop
        # kde
        niri

        gaming

        obs-studio
        music
        art
      ];

      networking.hostName = "persephone";
      services = {
        openssh.enable = true;
        flatpak.enable = true;
      };

      preferences.user = {
        enable = true;
        enableHjemUser = true;
        name = "kodie";
        face = ./avatar.png;
      };

      hjem.users.${config.preferences.user.name}.rum.programs.git = {
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

      services.displayManager.defaultSession = lib.mkForce "niri";

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
