{ stdenv, fetchFromGitHub, cmake, gtest, cpp2py, hdf5, ncurses, python3Packages
}:

stdenv.mkDerivation rec {
  pname = "h5";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256:07lahznp5cbkk2nnb88lia8s9qfgrwgb6y654ql4fss574skga5w";
  };

  patches = [ ./h5.patch ];
  nativeBuildInputs = [ cmake gtest ];
  buildInputs = [ cpp2py hdf5 ncurses ];
  propagatedBuildInputs = with python3Packages; [ numpy ];

  doCheck = true;
}