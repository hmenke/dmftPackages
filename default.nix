{ pkgs ? (import
    (
      let
        lock = builtins.fromJSON (builtins.readFile ./flake.lock);
      in
      fetchTarball (with lock.nodes.nixpkgs.locked; {
        url = "https://github.com/${owner}/${repo}/archive/${rev}.tar.gz";
        sha256 = narHash;
      })
    )
    { })
}:

with pkgs;
let
  stdenvOverrides = lib.optionalAttrs stdenv.isDarwin {
    stdenv = overrideInStdenv clang13Stdenv [ llvmPackages.openmp ];
  };
  mpiOverride = lib.optionalAttrs (!pkgs ? mpi) { mpi = openmpi; };
  boostOverride = lib.optionalAttrs (lib.versionOlder boost.version "1.75.0") { boost = boost175; };
  newScope = extra: lib.callPackageWith (pkgs // stdenvOverrides // mpiOverride // boostOverride // extra);
in
lib.makeScope newScope (self:
  with self; {
    alpsPackages = callPackage ./alpsPackages { };

    nfft = callPackage ./nfft { };

    omegamaxent = callPackage ./omegamaxent { };

    pomerolPackages = callPackage ./pomerolPackages { };

    triqsPackages = callPackage ./triqsPackages { };

    w2dynamics = callPackage ./w2dynamics { };
  })
