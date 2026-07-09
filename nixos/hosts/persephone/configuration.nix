{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone =
    # { pkgs, ... }:
    {
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

      # users.users.kodie = {
      #   isNormalUser = true;
      #   description = "kodie";
      #   extraGroups = [
      #     "networkmanager"
      #     "wheel"
      #   ];
      #   initialPassword = "kodie";
      #   shell = pkgs.nushell;
      # };

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
      boot.kernelModules = [ "uinput" ];

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = [ ];

      system.stateVersion = "26.05"; # WARN: No changing wili nilli
    };
}
