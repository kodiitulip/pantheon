{
  perSystem =
    { pkgs, ... }:
    {
      packages.steam-art-manager = pkgs.steam-art-manager.overrideAttrs (old: rec {
        version = "3.19.2";
        src = pkgs.fetchurl {
          url = "https://github.com/Tormak9970/Steam-Art-Manager/releases/download/v${version}/steam-art-manager.AppImage";
          hash = "sha256-b5zUx16FSUNPfZxOGoGzd5mUSc6RbK7hLcfewsPx/vQ=";
        };
      });
    };
}
