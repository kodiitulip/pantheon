{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [ godot ];
    };
}
