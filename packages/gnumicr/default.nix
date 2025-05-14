{ 
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  ... 
}: 

stdenvNoCC.mkDerivation {
  pname = "gnumicr";
  version = "0.30";

  src = fetchFromGitHub {
    owner = "alerque";
    repo = "gnumicr";
    rev = "v0.30";
    hash = "sha256-v9OGM8UTDYvxRZZrVq8BnBCwWlQr+Zv0ncDF2xk7HY4=";
  };

  installPhase = ''
    runHook preInstall

    install -m444 -Dt $out/share/fonts/TTF/ GnuMICR.ttf
    install -m444 -Dt $out/share/fonts/Type1/ GnuMICR.pfb GnuMICR.pfm GnuMICR.afm
    install -m444 -Dt $out/share/fonts/OTF/ GnuMICR.otf
    install -m444 -Dt $out/share/licenses/GnuMICR/ COPYING AUTHORS
    install -m444 -Dt $out/share/doc/GnuMICR/ CHANGELOG README NEWS

    runHook postInstall
  '';

  meta = with lib; {
    description = "GnuMICR Font";
    homepage = "https://sandeen.net/GnuMICR/";
    license = licenses.gpl2Only;
    platforms = platforms.all;
    maintainers = [];
  };
}
