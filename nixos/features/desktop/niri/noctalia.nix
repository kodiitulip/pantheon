{ self, inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, config, ... }: {
    imports = [
      inputs.noctalia-greeter.nixosModules.default
      inputs.noctalia-greeter.hjemModules.default
    ];

    environment.systemPackages = [ ];

    programs.noctalia-greeter = {
      enable = true;
      greeter-args = "";
      settings = {
        cursor = {
          theme = "BreezeX-RosePine-Linux";
          size = 24;
          path = "${pkgs.rose-pine-cursor}/share/icons";
        };
        keyboard = {
          layout = "br";
          variant = "nodeadkeys";
          options = "compose:rctrl";
          numlock = true;
        };
        session.default = "niri";
        user.default = config.preferences.user.name;
        auth.allow_empty_passwords = false;
        appearance = {
          hide_logo = true;
          password_style = "random";
          scheme = "Synced";
          corner_radius_scale = 0.0;
          font_family = "Monocraft";
          wallpaper = {
            path = "color:${self.theme.rose-pine-dark.base00}";
            fill_mode = "crop";
            fill_color = self.theme.rose-pine-dark.base00;
          };
        };
      };
    };

    programs.noctalia = {
      enable = true;
      package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
      recommendedServices.enable = true;
    };

    hjem = {
      extraModules = [ inputs.noctalia.nixosModules.default ];

      programs.noctalia = {
        enable = true;
        package = null;
        validateConfig = true;
        settings = { };
        # customPalettes.rose-pine-nix = {
        #   dark = {};
        #   light = {};
        # };
      };
    };
  };
}
