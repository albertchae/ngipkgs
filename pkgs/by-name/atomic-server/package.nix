{
  lib,
  fetchFromGitHub,
  fetchCrate,
  rustPlatform,
  atomic-browser,
}: let
  inherit
    (lib)
    licenses
    ;
in
  rustPlatform.buildRustPackage rec {
    pname = "atomic-server";
    version = "0.37.0";

#    src = fetchFromGitHub {
#      owner = "atomicdata-dev";
#      repo = pname;
#      rev = "v${version}";
#      hash = "sha256-+Lk2MvkTj+B+G6cNbWAbPrN5ECiyMJ4HSiiLzBLd74g=";
#    };

    src = fetchFromGitHub {
      owner = "albertchae";
      repo = pname;
      rev = "37.0-searchpath";
      hash = "sha256-aeQSka2EHU9ysyw4OLUyIhleox8I/Fcq0e4nYwajCSs=";
    };

    cargoHash = "sha256-cSv1XnuzL5PxVOTAUiyiQsMHSRUMaFDkW2/4Bt75G9o=";

    postUnpack = ''
      mkdir -p $TMP/source/server/assets_tmp
      cp -r ${atomic-browser}/* $TMP/source/server/assets_tmp
    '';

    doCheck = false; # TODO(jl): broken upstream

    meta = {
      description = "A Rust library to serialize, parse, store, convert, validate, edit, fetch and store Atomic Data. Powers both atomic-cli and atomic-server.";
      homepage = "docs.atomicdata.dev";
      license = licenses.mit;
    };
  }
