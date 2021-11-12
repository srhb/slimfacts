{ pkgs ? import ./nixpkgs.nix {} }:
## https://nixos.org/manual/nixpkgs/stable/#chap-functions
# Pseudotypes inlined hopefully for clarity :-)
# filterAttrs :: (String -> Any -> Bool) -> AttrSet -> AttrSet
# mapAttrs'   :: (String -> Any -> { name = String; value = Any }) -> AttrSet -> AttrSet
let
  lib = pkgs.lib;
  jsonHosts =
    let
      files = lib.filterAttrs (filename: type: type == "regular" && lib.hasSuffix ".json" filename)
        (builtins.readDir ./hosts);
    in
      lib.mapAttrs' (filename: _:
      rec {
        name = value.uuid;
        value = builtins.fromJSON (builtins.readFile (./hosts + "/${filename}"));
      })
      files;
in
rec {
  # AttrSet of hosts keyed by their uuid. Each `host` itself is an AttrSet of
  # hostName, ip, vendor, macAddress
  hosts-by.uuid = jsonHosts;

  # Implement or discuss implementation strategies for eg. `hosts-by.hostName`
  # -- an AttrSet with the same values as in `hosts-by.uuid` but keyed instead
  # by the hostName. Feel free to just discuss it in known terms (for example,
  # if you're more comfortable with Haskell functions or idioms that works just
  # fine for us!)
  #
  # Don't spend all your weekend on this and feel free to mutate the
  # "assignment" however you like if you think you have something more
  # interesting to say, we want to have a discussion more than we care about a
  # solution to the "assignment" itself.  :)
  #
  # For context: We have a bunch of hosts and we need to "select" specific
  # hosts using a number of different parameters. In the "real" repo, there's a
  # lot more data than the keys I kept in here.

  # hosts-by.hostName = ...
}
