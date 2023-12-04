{ mkDerivation, base, lib }:
mkDerivation {
  pname = "foo";
  version = "0.1.0.0";
  src = ./.;
  libraryHaskellDepends = [ base ];
  license = "unknown";
}
