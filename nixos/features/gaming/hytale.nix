{ inputs, ... }:
{
  flake.nixosModules.gaming =
    { config, ... }:
    let
      user = config.preferences.user.name;
    in
    {
      services.flatpak = {
        packages = [
          {
            appId = "com.hypixel.HytaleLauncher";
            bundle = inputs.hytale-launcher.outPath;
            sha256 = inputs.hytale-launcher.narHash;
          }
          {
            appId = "io.github.hyprismteam.Hyprism";
            bundle = inputs.hyprism.outPath;
            sha256 = inputs.hyprism.narHash;
          }
        ];
        overrides.settings = {
          "io.github.hyprismteam.Hyprism".Context = {
            sockets = [ "x11" ];
            filesystems = [
              "/nix/store"
              "/run/current-system/sw/bin:ro"
              "/etc/profiles/per-user/${user}/bin/"
            ];
          };
        };
      };
    };
}
