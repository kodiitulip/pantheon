{
  perSystem =
    { pkgs, ... }:
    {
      packages.packweave =
        let
          inherit (pkgs) fetchurl;
          inherit (pkgs.stdenv) mkDerivation;
        in
        mkDerivation rec {
          pname = "packweave";
          version = "2.0.1";

          src = fetchurl {
            url = "https://github.com/packweavers/packweave/releases/download/v${version}/packweave-linux-amd64.deb";
            hash = "sha256-Yex01fI1rRIbcRXZT3RKz17vUIVPi/kDBwTD2gl54Vo=";
          };

          dontConfigure = true;
          dontBuild = true;
          dontStrip = true;
          dontDebug = true;

          nativeBuildInputs = with pkgs; [
            dpkg
            autoPatchelfHook
            makeWrapper
            wrapGAppsHook3
          ];

          buildInputs = with pkgs; [
            webkitgtk_4_1
            gtk3
            hicolor-icon-theme
            glib
            gdk-pixbuf
            pango
            cairo
            atk
            libsoup_3
            git
          ];

          unpackPhase = ''
            runHook preUnpack
            dpkg-deb --fsys-tarfile $src | tar -x --no-same-owner
            runHook postUnpack
          '';

          installPhase = ''
            runHook preInstall

            mkdir -p $out
            cp -r usr/* $out/

            if [ -d $out/bin ]; then
              chmod +x $out/bin/* || true
            fi

            runHook postInstall
          '';

          meta = {
            description = "A Minecraft modpack IDE.";
            homepage = "https://github.com/packweavers/packweave";
            app = pname;
            platforms = [ "x86_64-linux" ];
          };
        };
    };
}
