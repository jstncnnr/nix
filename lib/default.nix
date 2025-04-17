lib: {
  mkNixosHost = self: hostname: system: usernames: {
    name = hostname;
    value = lib.nixosSystem {
      system = system;
      specialArgs = {
        inherit self hostname usernames lib;
	inherit (self) inputs;
      };
      modules = [
        ../hosts/${hostname}
	../modules/nixos
      ];
    };
  };
}
