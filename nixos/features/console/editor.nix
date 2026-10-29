{
  flake.nixosModules.console =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        neovim
        vis
      ];
    };
}
