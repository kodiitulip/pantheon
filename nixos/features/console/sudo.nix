{
  flake.nixosModules.console =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      security.sudo = {
        enable = true;
        extraConfig = ''
          Defaults env_reset,pwfeedback
        '';
      };
      security.doas = {
        enable = false;
        extraConfig = "";
        extraRules = [
          {
            groups = [ "wheel" ];
            keepEnv = true;
            persist = true;
          }
        ];
      };
      environment.systemPackages = lib.mkIf config.security.doas.enable (with pkgs; [ doas-sudo-shim ]);
    };
}
