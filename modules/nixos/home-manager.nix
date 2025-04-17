{ lib, config, usernames, inputs, pkgs, ... }:
let
  buildUserConfig = username: { 
    home.username = username;
    home.homeDirectory = "/home/${username}";
    home.stateVersion = config.system.stateVersion;
  };
in
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  options = {
    programs.home-manager.enable = lib.mkEnableOption "Home Manager";
  };

  config = lib.mkIf config.programs.home-manager.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      
      users = lib.listToAttrs (lib.lists.forEach usernames (username: {
        name = lib.toLower username;
	value = lib.recursiveUpdate 
	  (buildUserConfig (lib.toLower username)) 
	  ((import ../../home/${username}) { inherit lib inputs pkgs; });
      }));
    };
  };
}
