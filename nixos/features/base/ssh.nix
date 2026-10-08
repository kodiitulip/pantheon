{
  flake.nixosModules.base = {
    services.openssh = {
      enable = true;
      openFirewall = true;
      settings = {
        PermitRootLogin = "no";
        AllowUsers = [
          "julia"
          "kodie"
          "caju"
        ];
      };
    };
  };
}
