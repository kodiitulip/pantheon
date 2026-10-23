{
  flake.nixosModules.console =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        helix
        neovim
        vis
      ];
    };
}
