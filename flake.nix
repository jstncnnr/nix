{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    snowfall-lib.url = "github:snowfallorg/lib";
    snowfall-lib.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:NotAShelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      inherit inputs;
      src = builtins.path {
        path = ./.;
        name = "source";
      };
    };
}
