{ inputs, ...}:
{
    flake.nixosModules.hjem =
    { pkgs, config, ... }:
    let
        inherit (config.preferences.user) name face;
    in
    {
        imports = [
            inputs.hjem.nixosModules.default
        ];

        hjem = {
            extraModules = [ inputs.hjem-rum.hjemModules.default ];
            users."${name}" = {
                enable = true;
                directory = "/home/${name}";
                user = "${name}";
                files.".face.icon".source = face;
            };

            clobberByDefault = true;
        };
    };
}
