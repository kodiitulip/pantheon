{
  flake.nixosModules.base =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      options.preferences.user = {
        enable = lib.mkEnableOption "user";
        enableHjemUser = lib.mkEnableOption "hjemUser";
        name = lib.mkOption {
          type = lib.types.str;
          default = "";
        };
        face = lib.mkOption {
          type = lib.types.path;
          default = ./avatar.png;
        };
      };

      config =
        let
          inherit (config.preferences.user)
            name
            face
            enable
            enableHjemUser
            ;
        in
        lib.mkIf (name != "" && enable) {
          users.users.${name} = {
            isNormalUser = true;
            description = name;
            extraGroups = [
              "networkmanager"
              "wheel"
            ];
            initialPassword = name;
            shell = pkgs.nushell;
          };
          hjem.users.${name} = lib.mkIf enableHjemUser {
            enable = true;
            directory = "/home/${name}";
            user = name;
            files.".face.icon".source = face;
          };
        };
    };
}
