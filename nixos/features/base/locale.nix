{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernelPackages = pkgs.linuxPackages_latest;
      };

      networking.networkmanager.enable = true;
      networking.firewall = {
        allowedTCPPorts = [
          3000
          8080
          25565
          35565
        ];
        allowedUDPPorts = [ ];
      };

      services.xserver.xkb = {
        layout = "br";
        variant = "";
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

      console.keyMap = "br-abnt2";
    };
}
