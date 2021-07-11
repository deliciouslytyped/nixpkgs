#TODO@deliciouslytyped The tool seems to unnecessarily force mutable access for the debugedit `-l` feature
{fetchgit, lib, stdenv, autoreconfHook, pkgconfig, elfutils, help2man, util-linux}:
stdenv.mkDerivation {
  name = "debugedit";
  version = "unstable-2021-07-05";

  buildInputs = [ autoreconfHook pkgconfig elfutils help2man ];
  checkInputs = [ util-linux ]; # Tests use `rev`

  src = fetchgit {
    url = "git://sourceware.org/git/debugedit.git";
    rev = "e04296ddf34cbc43303d7af32ab3a73ac20af51a";
    sha256 = "19cjkpzhdn2z6fl7xw8556m6kyrb7nxwbz2rmiv2rynyp74yg44z";
  };

  preBuild = ''
    patchShebangs scripts/find-debuginfo.in
  '';

  doCheck = true;

  meta = with lib; {
    description = "debugedit provides programs and scripts for creating debuginfo and source file distributions, collect build-ids and rewrite source paths in DWARF data for debugging, tracing and profiling.";
    homepage = "https://sourceware.org/debugedit/";
    license = licenses.gpl2;
    platforms = platforms.all;
    maintainers = with maintainers; [ deliciouslytyped ];
  };
}
