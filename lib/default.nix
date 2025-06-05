{ lib }:

{
  mkHost = { system, arch, hostname }:
    {
      name = hostname;
      value = system {
        system = arch;
        modules = [
          ../hosts/${arch}/${hostname}
        ];
      };
    };

  buildModuleMetadata = path:
    let
      hasDefaultNix = dir:
        let
          file = lib.filterAttrs (name: type: name == "default.nix" && type == "regular") (builtins.readDir "${path}/${dir}");
        in
          file != null;

      isNixFile = file:
        let
          matcher = builtins.match ".*\\.([^.]+)$" file;
          extension = if matcher == null then null else builtins.elemAt matcher 0;
        in
          extension == "nix";

      basename = file:
        let
          matcher = builtins.match "^(.*)\\.[^./]+$" file;
        in
          if matcher == null then null else builtins.elemAt matcher 0;

      entries = builtins.readDir path;

      directories =
        builtins.listToAttrs
          (builtins.map (dir: { name = dir; value = "${path}/${dir}"; }) 
            (builtins.attrNames 
              (lib.filterAttrs (dir: type: type == "directory" && (hasDefaultNix dir)) 
                entries)));

      files = 
        builtins.listToAttrs
          (builtins.map (file: { name = (basename file); value = "${path}/${file}"; })
            (builtins.attrNames
              (lib.filterAttrs (file: type: type == "regular" && (isNixFile file)) 
                entries)));
    in
      directories // files;
}
