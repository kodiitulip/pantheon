{
    flake.nixosModules.obs-studio =
    { pkgs, ... }:
    {
        programs.obs-studio = {
            enable = true;
            plugins = with pkgs.obs-studio-plugins; [
                wlrobs
                waveform
                obs-websocket
                obs-pipewire-audio-capture
                obs-vkcapture
                obs-tuna
            ];
            enableVirtualCamera = true;
        };
    };
}
