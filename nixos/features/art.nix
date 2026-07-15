{
  flake.nixosModules.art =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        krita
        aseprite
        blockbench
        blender
      ];

      hardware.opentabletdriver.enable = true;
    };
}
