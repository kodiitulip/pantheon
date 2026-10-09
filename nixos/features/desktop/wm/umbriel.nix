{ self, inputs, ... }:
{
  flake.nixosModules.umbriel =
    { pkgs, config, ... }:
    let
      pkgs' = self.packages.${pkgs.stdenv.hostPlatform.system};
      username = config.preferences.user.name;
    in
    {
      imports = [ inputs.umbriel.nixosModules.default ];
      programs.umbriel.enable = true;

      hjem.extraModules = [ inputs.umbriel.hjemModules.default ];
      hjem.users.${username}.programs.umbriel = {
        enable = true;
        # settings = {
        #   general = {
        #     autostart = [ "noctalia" ];
        #     xwayland_native_resolution = true;
        #   };
        #   screencast.disable_dynamic_confirmation = true;
        #   include.optional.files = [ "noctalia.toml" ];
        #   layout.gap = 5;
        #   input.keyboard = {
        #     layout = "br";
        #     variant = "nodeadkeys";
        #     options = "compose:rctrl";
        #     numlock = true;
        #   };
        #   keybinds = {
        #     "Mod+Return" = "spawn:kitty";
        #     "Mod+Q" = "window-close";
        #     "Mod" = "spawn:noctalia msg panel-toggle launcher";
        #   };
        # };
      };

      environment.systemPackages =
        with pkgs;
        with pkgs';
        [
          xwayland
          playerctl
          brightnessctl
        ];
    };
}
