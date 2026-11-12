{ inputs, ... }:
{
  flake.nixosModules.base =
    { config, ... }:
    let
      user = config.preferences.user.name;
    in
    {
      imports = [ inputs.nix-flatpak.nixosModules.nix-flatpak ];
      services.flatpak = {
        enable = true;
        overrides.settings = {
          global = {
            Context = {
              sockets = [
                "wayland"
                "!x11"
                "!fallback-x11"
              ];
              filesystems = [ "/nix/store:ro" ];
            };
            Environment = {
              XCURSOR_PATH = "/run/current-system/sw/share/icons:/etc/profiles/per-user/${user}/share/icons";
              GTK_THEME = "adw-gtk3-dark";
              ICON_THEME = "Papirus-Dark";
              CURSOR_THEME = "Opaque_Black";
            };
          };
        };
      };
    };
}
