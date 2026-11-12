{ inputs, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        comixcursors.Opaque_Black
        papirus-icon-theme
        sqlite
        hyprpicker
        mpv
        mpvpaper
        python3
        nix-search-tv
        fzf
      ];

      programs.noctalia = {
        enable = true;
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        recommendedServices.enable = true;
      };
    };
}
