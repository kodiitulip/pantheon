{ inputs, ... }:
{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    let
      username = config.preferences.user.name;
    in
    {
      nixpkgs.overlays = [ inputs.millennium.overlays.default ];
      programs = {
        gamemode.enable = true;
        gamescope.enable = true;
        steam = {
          enable = true;
          package = pkgs.millennium-steam.override {
            extraPkgs =
              pkgs': with pkgs'; [
                libXcursor
                libXi
                libXinerama
                libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib # Provides libstdc++.so.6
                libkrb5
                keyutils
              ];
          };
          extest.enable = true;
          protontricks.enable = true;
          remotePlay.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          extraPackages = with pkgs; [
            gamescope
            hidapi
          ];
          extraCompatPackages = [ pkgs.proton-ge-bin ];
        };
      };

      services.udev.extraRules = ''
        KERNEL=="uinput", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:09CC.*", MODE="0666"
      '';

      environment.systemPackages = with pkgs; [
        python314Packages.ds4drv
        steamcmd
        steam-tui
      ];
      hjem.users.${username}.packages = with pkgs; [
        steam-art-manager
        protonup-qt
      ];
    };
}
