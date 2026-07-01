{
  flake.nixosModules.base =
    { lib, ... }:
    {
      options.preferences.user = {
        name = lib.mkOption {
          type = lib.types.str;
          default = "kodie";
        };
        face = lib.mkOption {
          type = lib.types.path;
          default = ./avatar.png;
        };
      };
    };
}
