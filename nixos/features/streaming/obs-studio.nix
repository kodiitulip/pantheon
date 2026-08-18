{
  flake.nixosModules.obs-studio =
    { pkgs, ... }:
    {
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          waveform
          obs-pipewire-audio-capture
          droidcam-obs
          advanced-scene-switcher
          obs-scene-as-transition
          obs-vkcapture
          obs-tuna
        ];
        enableVirtualCamera = true;
      };
    };
}
