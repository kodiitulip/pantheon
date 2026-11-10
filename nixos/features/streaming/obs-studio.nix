{
  flake.nixosModules.obs-studio =
    { pkgs, ... }:
    {
      enviroment.systemPackages = with pkgs; [ obs-do ];
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
