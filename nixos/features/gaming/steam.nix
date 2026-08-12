{ inputs, ... }:
{
  flake.nixosModules.gaming =
    { pkgs, config, ... }:
    {
      nixpkgs.overlays = [ inputs.millennium.overlays.default ];
      programs.gamemode.enable = true;
      programs.steam = {
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
        extraCompatPackages = with pkgs; [
          proton-ge-bin
        ];
      };
      programs.gamescope.enable = true;
      services.udev.extraRules = ''
        KERNEL=="uinput", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:05C4.*", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0666"
        KERNEL=="hidraw*", SUBSYSTEM=="hidraw", KERNELS=="0005:054C:09CC.*", MODE="0666"
      '';

      environment.systemPackages = [ pkgs.python314Packages.ds4drv ];
      hjem.users.${config.preferences.user.name}.packages = with pkgs; [
        steam-art-manager
        protonup-qt
      ];
    };
}
