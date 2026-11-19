{
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.pngtuber-remix =
        let
          inherit (pkgs)
            fetchFromGitHub
            godot_4_7
            ;
          inherit (pkgs.stdenv) mkDerivation;
          godot = godot_4_7;
        in
        mkDerivation rec {
          pname = "pngtuber-remix";
          version = "1.4.7";

          src = fetchFromGitHub {
            owner = "MudkipWorld";
            repo = "PNGTuber-Remix";
            rev = "v${version}";
            hash = "sha256-2SCfTTomiVO9zymS2DaZSKOHWrxBkhnMTJklnniqBRg=";
          };

          strictDeps = true;

          nativeBuildInputs = with pkgs; [
            godot
            pkg-config
          ];

          buildPhase = ''
            runHook preBuild

            export HOME=$(mktemp -d)
            mkdir -p $HOME/.local/share/godot/
            ln -s "${godot.export-template}"/share/godot/export_templates "$HOME"/.local/share/godot/
            mkdir -p build
            godot --headless --export-release "Linux/X11" ./build/${pname}

            runHook postBuild
          '';

          installPhase = ''
            runHook preInstall

            install -D -m 755 -t $out/libexec ./build/*
            install -D -m 644 -t $out/share/applications ./packaging/linux/io.github.mudkipworld.pngtuber-remix.desktop
            install -D -m 644 -T ./PicklesSurprised.png $out/share/icons/hicolor/256x256/apps/io.github.mudkipworld.pngtuber-remix.png
            install -d -m 755 $out/bin
            ln -s $out/libexec/${pname}.sh $out/bin/${pname}

            runHook postInstall
          '';

          passthru.updateScript = pkgs.nix-update-script { };

          meta = {
            description = "Start PNGTubing in a more interesting and alive way";
            homepage = "https://mudkipworld.itch.io/pngremix";
            app = pname;
            platforms = [ "x86_64-linux" ];
            license = lib.licenses.mit;
          };
        };
    };
}
