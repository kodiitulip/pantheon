{
  perSystem =
    { pkgs, ... }:
    {
      packages.root =
        let
          inherit (pkgs) fetchurl;
          inherit (pkgs.appimageTools) wrapType2 extract;
          pname = "root";
          version = "0.9.127";
          src = fetchurl {
            url = "https://installer.rootapp.com/installer/Linux/X64/Root.AppImage";
            hash = "sha256-LFTZZC9qhHdRgQXzNa6j74hNn8oxjIR/J+bTM0DB3Js=";
          };
          contents = extract { inherit pname version src; };
        in
        wrapType2 {
          inherit pname version src;
          extraPkgs = pkgs: with pkgs; [ noto-fonts-color-emoji ];
          extraInstallCommands = ''
            install -m 644 -D ${contents}/Root.desktop $out/share/applications/root.desktop
            install -m 644 -D ${contents}/Root.png $out/share/icons/hicolor/512x512/apps/root.png
            substituteInPlace $out/share/applications/root.desktop \
              --replace-fail 'Exec=Root' 'Exec=root'
            substituteInPlace $out/share/applications/root.desktop \
              --replace-fail 'Icon=Root' 'Icon=root'
          '';
        };
    };
}
