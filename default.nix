{ pkgs ? import <nixpkgs> { } }:

with pkgs;

let

  stdenvOverrides = lib.optionalAttrs stdenv.isDarwin {
    stdenv = overrideInStdenv stdenv [ llvmPackages.openmp ];
  };

  newScope = extra: lib.callPackageWith (pkgs // stdenvOverrides // extra);

in lib.makeScope newScope (self: with self; {

  alpsPackages = callPackage ./alps { };

  nfft = callPackage ./nfft { };

  triqsPackages = callPackage ./triqs { };

  w2dynamics = callPackage ./w2dynamics { };

})
