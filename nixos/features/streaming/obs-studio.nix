{ self, ... }:
{
  flake.nixosModules.obs-studio =
    { pkgs, ... }:
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
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
          # obs-tuna
          self.packages.${system}.obs-tuna
        ];
        enableVirtualCamera = true;
      };
    };

  perSystem =
    { pkgs, lib, ... }:
    {
      packages.obs-tuna = pkgs.stdenv.mkDerivation (finalAttrs: {
        pname = "obs-tuna";
        version = "1.9.11";

        nativeBuildInputs = with pkgs; [
          cmake
          pkg-config
          qt6Packages.wrapQtAppsHook
          git
        ];
        buildInputs = with pkgs; [
          obs-studio
          qt6Packages.qtbase
          zlib
          curl
          dbus
          taglib
          libmpdclient
          utf8cpp
        ];

        cmakeFlags = [
          "-DFETCHCONTENT_SOURCE_DIR_TAGLIB=${pkgs.taglib.src}"
        ];

        src = pkgs.fetchFromGitHub {
          owner = "univrsal";
          repo = "tuna";
          rev = "1a13ce5db9e24e7bddfdd5be711505ee3363f003";
          hash = "sha256-gzwqPEwqM7YPArU5n6P7fWbKlEwfYXIxDhRgMyTaodg=";
          fetchSubmodules = true;
        };

        dontWrapQtApps = true;

        meta = {
          description = "Song information plugin for obs-studio";
          homepage = "https://github.com/univrsal/tuna";
          license = lib.licenses.gpl2Only;
          maintainers = with lib.maintainers; [ shortcord ];
          platforms = lib.platforms.linux;
        };
      });
    };
}
