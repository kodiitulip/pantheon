{ self, inputs, ... }:
{
  flake.nixosConfigurations.persephone = inputs.nixpkgs.lib.nixosSystem {
    modules = [ self.nixosModules.persephone ];
  };

  flake.nixosModules.persephone =
  { pkgs, config, ... }:
  {
    imports = with self.nixosModules; [
      nix
      git
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.kernelPackages = pkgs.linuxPackages_latest;

    networking.hostName = "persephone";
    networking.networkmanager.enable = true;
    networking.firewall = {
      allowedTCPPorts = [ 3000 8080 25565 35565 ];
      allowedUDPPorts = [ ];
    };

    time.timeZone = "America/Fortaleza";
    i18n.defaultLocale = "en_US.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "pt_BR.UTF-8";
      LC_IDENTIFICATION = "pt_BR.UTF-8";
      LC_MEASUREMENT = "pt_BR.UTF-8";
      LC_MONETARY = "pt_BR.UTF-8";
      LC_NAME = "pt_BR.UTF-8";
      LC_NUMERIC = "pt_BR.UTF-8";
      LC_PAPER = "pt_BR.UTF-8";
      LC_TELEPHONE = "pt_BR.UTF-8";
      LC_TIME = "pt_BR.UTF-8";
    };

    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    services.xserver.xkb = {
      layout = "br";
      variant = "";
    };
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
    services.openssh.enable = true;

    console.keyMap = "br-abnt2";

    users.users.kodie = {
      isNormalUser = true;
      description = "kodie";
      extraGroups = [ "networkmanager" "wheel" ];
      initialPassword = "kodie";
      shell = pkgs.nushell;
    };

    programs = {
      firefox.enable = true;
      steam.enable = true;
      steam.extest.enable = true;
      steam.protontricks.enable = true;
      steam.remotePlay.openFirewall = true;
      steam.localNetworkGameTransfers.openFirewall = true;

    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = [ ];

    system.stateVersion = "26.05"; # WARN: No changing wili nilli
  };
}
