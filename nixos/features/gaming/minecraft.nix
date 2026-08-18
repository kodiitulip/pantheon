{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        (prismlauncher.override {
          additionalPrograms = [
            ffmpeg
            vlc
          ];
          jdks = [
            graalvmPackages.graalvm-ce
            zulu17
            zulu21
            temurin-bin-21
          ];
        })
      ];
    };
}
