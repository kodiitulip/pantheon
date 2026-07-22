{ self, ... }:
{
  flake.nixosModules.persephone =
    { pkgs, config, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        kdePackages.kate
        neovim
        zed-editor

        easyeffects
        selfpkgs.zen

        r2modman
        (discord.override {
          withVencord = true;
          withOpenASAR = true;
        })

        sunshine

        prismlauncher
      ];
    };
}
