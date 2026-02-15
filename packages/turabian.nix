{
  lib,
  stdenvNoCC,
  version,
  src,
}:

stdenvNoCC.mkDerivation {
  pname = "turabian";
  inherit src version;

  dontBuild = true;

  installPhase =
    let
      outDir = "$out/lib/typst-packages/turabian/${version}";
    in
    ''
      runHook preInstall
      mkdir -p ${outDir}
      cp -r template lib.typ typst.toml ${outDir}/
      if [ -f LICENSE ]; then
        cp LICENSE ${outDir}/
      fi
      if [ -f README.md ]; then
        cp README.md ${outDir}/
      fi
      runHook postInstall
    '';

  meta = {
    description = "A Typst Template for the Chicago Turabian format";
    homepage = "https://github.com/Multipixelone/typst-turabian";
    license = lib.licenses.mit;
    platforms = lib.platforms.all;
  };
}
