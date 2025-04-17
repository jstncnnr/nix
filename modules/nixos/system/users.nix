{ lib, usernames, pkgs, ... }:
let
  capitalizeWord = word:
    if word == "" then ""
    else lib.toUpper (lib.substring 0 1 word) + lib.substring 1 (lib.stringLength word - 1) word;

  toTitleCase = str:
    let
      words = lib.splitString " " str;
    in
      lib.concatStringsSep " " (map capitalizeWord words);
in
{
  users.users = lib.listToAttrs (lib.lists.forEach usernames (username: {
    name = lib.toLower username;
    value = {
      isNormalUser = true;
      description = toTitleCase username; 
      extraGroups = [ "networkmanager" "wheel" ];
      shell = pkgs.zsh;
    };
  }));
}
