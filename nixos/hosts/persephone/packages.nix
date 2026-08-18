{ self, ... }:
{
  flake.nixosModules.persephone =
    { pkgs, config, ... }:
    let
      pkgs' = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages = with pkgs; [
        neovim
        unzip
        easyeffects
        zed-editor
        pkgs'.zen
        firefoxpwa
      ];
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        godot
        r2modman
        (discord.override {
          withVencord = true;
          withOpenASAR = true;
        })
        stremio-linux-shell
        croc
      ];
    };
}
