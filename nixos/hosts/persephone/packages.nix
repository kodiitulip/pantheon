{ inputs, self, ... }:
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
          easyeffects
          zed-editor
          firefoxpwa
          qbittorrent
          croc
          zen
        ];

      hjem.users.${config.preferences.user.name}.packages =
        with pkgs;
        with pkgs';
        [
          (discord.override { withVencord = true; })
          vesktop
          inputs.rootapp.packages.${system}.default

          stremio-linux-shell
          r2modman
          packweave
          obsidian
          pureref
        ];
    };
}
