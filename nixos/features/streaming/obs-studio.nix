{
  flake.nixosModules.obs-studio =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          droidcam-obs
          obs-vkcapture
          obs-tuna
        ];
        enableVirtualCamera = true;
      };
    };
}
