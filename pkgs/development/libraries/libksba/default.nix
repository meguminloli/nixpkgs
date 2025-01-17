{ buildPackages, lib, stdenv, fetchurl, gettext, libgpg-error }:

stdenv.mkDerivation rec {
  pname = "libksba";
  version = "1.5.1";

  src = fetchurl {
    url = "mirror://gnupg/libksba/libksba-${version}.tar.bz2";
    sha256 = "sha256-sPTGXk5EfZojSfa4wOd6KL6VMeRUi6AsVF0fRtx7+SE=";
  };

  outputs = [ "out" "dev" "info" ];

  buildInputs = [ gettext ];
  propagatedBuildInputs = [ libgpg-error ];
  depsBuildBuild = [ buildPackages.stdenv.cc ];

  configureFlags = [ "--with-libgpg-error-prefix=${libgpg-error.dev}" ];

  postInstall = ''
    mkdir -p $dev/bin
    mv $out/bin/*-config $dev/bin/
    rmdir --ignore-fail-on-non-empty $out/bin
  '';

  meta = with lib; {
    homepage = "https://www.gnupg.org";
    description = "CMS and X.509 access library";
    platforms = platforms.all;
    maintainers = with maintainers; [ ];
    license = licenses.lgpl3;
  };
}
