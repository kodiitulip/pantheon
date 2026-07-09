{
  flake.nixosModules.art =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        krita
        pixelorama
      ];

      hardware.opentabletdriver.enable = true;
    };
}
