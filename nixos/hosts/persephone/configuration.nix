{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone =
  { pkgs, config, ... }:
  {
    imports = with self.nixosModules; [
      base
      hjem
      console

      nix
      git

      kde

      gaming

      obs-studio
      music
    ];

    networking.hostName = "persephone";
    services.openssh.enable = true;

    users.users.kodie = {
      isNormalUser = true;
      description = "kodie";
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "kodie";
      shell = pkgs.nushell;
    };

    preferences.user = {
      name = "kodie";
      face = ./avatar.png;
    };

    programs = {
      firefox.enable = true;
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ ];

    system.stateVersion = "26.05"; # WARN: No changing wili nilli
  };
}
