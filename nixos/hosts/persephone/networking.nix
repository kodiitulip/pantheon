{
  flake.nixosModules.persephone = _: {
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
