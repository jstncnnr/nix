{pkgs, ...}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "gnumicr";
  version = "0.30";

  src = pkgs.fetchFromGitHub {
    owner = "alerque";
    repo = "GnuMICR";
    rev = "v0.30";
    hash = "sha256-v9OGM8UTDYvxRZZrVq8BnBCwWlQr+Zv0ncDF2xk7HY4=";
  };

  installPhase = ''
    runHook preInstall

    install -Dm444 -t "$out/usr/share/fonts/TTF" GnuMICR.ttf
    install -Dm444 -t "$out/usr/share/fonts/Type1" GnuMICR.pfb GnuMICR.pfm GnuMICR.afm
    install -Dm444 -t "$out/usr/share/fonts/OTF" GnuMICR.otf
    install -Dm444 -t "$out/usr/share/licenses/GnuMICR/" COPYING AUTHORS
    install -Dm444 -t "$out/usr/share/doc/GnuMICR" CHANGELOG README NEWS

    runHook postInstall
  '';

  meta = {
    description = "A PostScript(tm) Type 1 MICR Font released under the GPL.";
    homepage = "https://sandeen.net/GnuMICR/";
    license = pkgs.lib.licenses.gpl2Only;
    platforms = pkgs.lib.platforms.all;
    maintainers = [];
  };
}
