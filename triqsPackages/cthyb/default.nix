{ stdenv
, lib
, fetchFromGitHub
, cmake
, gtest
, triqsPackages
, ncurses
, nfft
, openssh
}:

stdenv.mkDerivation rec {
  pname = "cthyb";
  version = "3.1.1";

  src = fetchFromGitHub {
    owner = "TRIQS";
    repo = pname;
    rev = version;
    sha256 = "sha256-FQpWAzW0DHmZGzLb6j/OSmm2Df9/WabRiqFAk8T8quQ=";
  };

  patches = [ ./cthyb.patch ];
  nativeBuildInputs = [ cmake gtest ];
  cmakeFlags = [ "-DBuild_Deps=Never" ];
  buildInputs = [ ncurses nfft ];
  propagatedBuildInputs = [ triqsPackages.triqs ];

  checkInputs = [ openssh ];
  doCheck = true;

  meta = {
    description = "A fast and generic hybridization-expansion solver";
    homepage = "https://triqs.github.io/cthyb/";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ hmenke ];
  };
}
