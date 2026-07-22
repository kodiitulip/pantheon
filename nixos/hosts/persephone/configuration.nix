{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone = {
    imports = with self.nixosModules; [
      base
      console

      nix
      git

      kde

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

    programs = {
      firefox.enable = true;
    };
    hardware.uinput.enable = true;
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = false;
    };

    boot.kernelModules = [ "uinput" ];

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ ];

    system.stateVersion = "26.05"; # WARN: No changing wili nilly
  };
}
