{ inputs, self, ... }:
{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      nixpkgs.overlays = [ inputs.vintagestory-nix.overlays.default ];

      hjem.extraModules = [ self.hjemModules.vintagestory-nix ];
      hjem.users.${config.preferences.user.name}.programs.mvl = {
        enable = true;
        settings.gameVersions = with pkgs.vintagestoryPackages; [
          v1-22-6
          v1-21-6
        ];
      };

    };

  flake.hjemModules.vintagestory-nix =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      inherit (lib.modules) mkIf;
      inherit (lib.options)
        literalExpression
        mkEnableOption
        mkPackageOption
        mkOption
        ;
      inherit (lib.types)
        package
        listOf
        str
        ;

      cfg = config.programs.mvl;
      packages = inputs.vintagestory-nix.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      options.programs.mvl = {
        enable = mkEnableOption "MVL";

        package = mkPackageOption packages "mvl" { };

        settings = {
          releaseFolder = mkOption {
            type = str;
            default = "MVL/Release";
            description = ''
              Path to the directory containing MVL's Vintage Story releases.

              Will be used as target to symlink the version packages on `gameVersions`
            '';
          };
          gameVersions = mkOption {
            type = listOf package;
            default = [ ];
            description = "List of Vintage Story packages to add in MVL.";
            example = literalExpression ''
              with pkgs.vintagestoryPackages; [
                v1-21-1
                v1-21-2-rc-2
              ]
            '';
          };
        };
      };

      config =
        let
          releases = map (
            vintagestory:
            let
              merged = vintagestory.overrideAttrs {
                postFixup = ''
                  mv $out/share/vintagestory/Vintagestory $out/share/vintagestory/Vintagestory-unwrapped
                  ln -s $out/bin/vintagestory $out/share/vintagestory/Vintagestory
                '';
              };
            in
            {
              name = "${cfg.settings.releaseFolder}/${vintagestory.version}";
              value = {
                source = "${merged}/share/vintagestory";
              };
            }
          ) cfg.settings.gameVersions;
        in
        mkIf cfg.enable {
          packages = mkIf (cfg.package != null) [ cfg.package ];
          xdg.data.files = (builtins.listToAttrs releases);
        };
    };
}
