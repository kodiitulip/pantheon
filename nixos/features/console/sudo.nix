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
          Defaults passpropmpt="\n[30m[40;36m  [0m[30m[0m [36m[0m "
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
