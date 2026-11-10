{
  flake.nixosModules.obs-studio =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ obs-cmd ];
      programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
          wlrobs
          obs-pipewire-audio-capture
          droidcam-obs
          obs-vkcapture
          obs-tuna
          obs-websocket
        ];
        enableVirtualCamera = true;
      };
    };
}
