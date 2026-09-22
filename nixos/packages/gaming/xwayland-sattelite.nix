{
  perSystem =
    { pkgs, ... }:
    {
      packages.xwayland-satellite = pkgs.xwayland-satellite.overrideAttrs (old: rec {
        version = "0.8.2";
        src = pkgs.fetchFromGitHub {
          owner = "Supreeeme";
          repo = "xwayland-satellite";
          rev = "add2795";
          hash = "sha256-0TxfMgqW0/BLD4M942c5DCKYrtPvzsPJwvdcco4LQUM=";
        };
        cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
          inherit (old) pname;
          inherit version src;
          hash = "sha256-s1gl9eR6Mt2QLrhfcowstPFjzwE/lz4PJhJzWYHoIHg=";
        };
      });
    };
}
