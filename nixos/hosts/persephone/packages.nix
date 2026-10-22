{ self, ... }:
{
  flake.nixosModules.persephone =
    { pkgs, config, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
      pkgs' = self.packages.${system};
    in
    {
      environment.systemPackages =
        with pkgs;
        with pkgs';
        [
          neovim
          easyeffects
          zed-editor
          firefoxpwa
          nurl
          godot
          qbittorrent
          croc
          zen
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
