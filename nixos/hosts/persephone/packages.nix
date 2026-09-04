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
        firefoxpwa
        pkgs'.zen
        pkgs'.root
      ];
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        godot
        r2modman
        (discord.override {
          withVencord = true;
          withOpenASAR = true;
          vencord =
            let
              streamfix = pkgs.fetchFromGitHub {
                owner = "bezumiya";
                repo = "GoLiveBypass";
                tag = "v1.1.11";
                hash = "sha256-rkyIibmo0yb+QJvUnLdgeZjyPlQuYHKNzFgpPikEzR8=";
              };
            in
            pkgs.vencord.overrideAttrs {
              preBuild = ''
                mkdir -p src/userplugins/
                cp -r ${streamfix}/goLiveBypass/ src/userplugins/
              '';
            };
        })
        stremio-linux-shell
        croc
      ];
    };
}
