{
  flake.nixosModules.persephone = _: {
    networking.hosts = {
      "172.24.145.167" = [ "julia-servers" ];
      "172.24.97.165" = [ "julia" ];
    };

    networking.firewall = {
      allowedTCPPorts = [
        80
        443
        3000
        8080
        25565
        35565
      ];
      allowedUDPPorts = [ ];
    };

    services.zerotierone = {
      enable = true;
      joinNetworks = [
        "bb720a5aaedee869" # julia's network
        "b9a18a606fecb004" # blossom-garden
      ];
    };
  };
}
