{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        (prismlauncher.override {
          additionalPrograms = [
            ffmpeg
            yt-dlp
            vlc
            yad
          ];
          jdks = [
            temurin-jre-bin-17
            temurin-jre-bin-21
            temurin-jre-bin-25
          ];
        })
      ];
    };
}
