{ inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        rose-pine-cursor
        rose-pine-icon-theme
        sqlite
        hyprpicker
        mpv
        mpvpaper
        python3
      ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        recommendedServices.enable = true;
      };
    };
}
