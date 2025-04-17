{
  description = "nix system flake with home-manager";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";
    
    disko.url = "github:nix-community/disko/latest";
    disko.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, disko, home-manager, ... }@inputs: 
  let
    lib = nixpkgs.lib.extend (final: _: (import ./lib final) // home-manager.lib);
    mkNixosHost = lib.mkNixosHost self;
  in
  {
    nixosConfigurations = lib.listToAttrs [
      (mkNixosHost "nixos" "x86_64-linux" [ "justin" "work" ])
    ];
  };
}
