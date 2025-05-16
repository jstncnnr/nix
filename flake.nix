{
  description = "nix system flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    darwin.url = "github:nix-darwin/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
  let
    lib = inputs.snowfall-lib.mkLib {
      inherit inputs;
      src = ./.;
    };

    sharedModuleRoot = lib.snowfall.fs.get-snowfall-file "sharedModules";
  in
    (lib.mkFlake {
      inherit inputs;
      src = ./.;
    }) // {
      sharedHomeModules = lib.snowfall.module.create-modules { src = "${sharedModuleRoot}/home"; }; 
      sharedNixosModules = lib.snowfall.module.create-module { src = "${sharedModuleRoot}/nixos"; };
      sharedDarwinModules = lib.snowfall.module.create-module { src = "${sharedModuleRoot}/darwin"; };
    };
}
