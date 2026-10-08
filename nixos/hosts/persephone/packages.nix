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
        steelix
        easyeffects
        zed-editor
        firefoxpwa
        nurl
        godot
        qbittorrent
        croc

        pkgs'.zen
      ];
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        (discord.override {
          withVencord = true;
          withOpenASAR = true;
        })
        stremio-linux-shell
        r2modman
      ];
    };
}
