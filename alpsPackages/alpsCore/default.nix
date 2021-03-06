{ stdenv
, lib
, fetchFromGitHub
, cmake
, boost
, eigen
, hdf5
, mpi
, openssh
}:

stdenv.mkDerivation rec {
  pname = "ALPSCore";
  version = "2.2.0";

  src = fetchFromGitHub {
    owner = "ALPSCore";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256:0brnbly6p227x2lw28rlx9wl64yff3x13wfy9kwl9jjil97r6ryl";
  };

  nativeBuildInputs = [ cmake ];
  cmakeFlags = [ "-DENABLE_MPI=On" "-DCMAKE_SKIP_BUILD_RPATH=OFF" ];
  buildInputs = [ boost eigen hdf5 mpi ];

  OMPI_MCA_rmaps_base_oversubscribe = "yes";
  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "Algorithms and Libraries for Physics Simulations";
    homepage = "https://github.com/ALPSCore/ALPSCore";
    license = lib.licenses.gpl2Only;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
