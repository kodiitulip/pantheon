{
  flake.nixosModules.obs-studio = {
    services.nginx = {
      enable = true;
      virtualHosts."layout.stream" = {
        root = "/var/www/stream-layout";
        listen = [
          {
            addr = "0.0.0.0";
            port = 80;
          }
        ];
        locations = {
          "/" = {
            tryFiles = "$uri $uri.html $uri/index.html $uri/ =404";
          };
          "/music" = {
            tryFiles = "$uri $uri.html $uri/index.html $uri/ =404";
          };
          "/404.html" = {
            extraConfig = ''
              internal;
            '';
          };
        };
        extraConfig = ''
          error_page 404 /404.html;
        '';
      };
    };
    networking = {
      hosts = {
        "127.0.0.1" = [ "layout.stream" ];
      };
      firewall.allowedTCPPorts = [
        80
        443
      ];
    };
  };
}
