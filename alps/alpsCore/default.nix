{ stdenv, fetchFromGitHub, cmake, boost, eigen, hdf5 }:

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
  buildInputs = [ boost eigen hdf5 ];
}
