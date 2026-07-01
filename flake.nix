{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # nixvim.url = "github:nix-community/nixvim";
    flake-parts.url = "github:hercules-ci/flake-parts";
    import-tree.url = "github:denful/import-tree";

    # disko.url = "github:nix-comunity/disko";
    hjem.follows = "hjem-rum/hjem";
    hjem-rum = {
      url = "github:snugnug/hjem-rum";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    # vintagestory-nix.url = "github:PierreBorine/vintagestory-nix";
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;
      mkFlake = inputs.flake-parts.lib.mkFlake { inherit inputs; };
      importModules = inputs.import-tree (i: i.filterNot (lib.hasInfix "flake.nix")) (
        i: i.filterNot (lib.hasInfix "templates/")
      ) (i: i ./.);
    in
    mkFlake importModules;
}
