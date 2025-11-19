{ pkgs ? import <nixpkgs> {} }:

let
  # FHS берём через pkgs.fhs.buildFHSUserEnv
  fhs = pkgs.fhs.buildFHSUserEnv;

  googleAntigravity = pkgs.stdenv.mkDerivation {
    pname = "antigravity-ide";
    version = "1.0";

    src = ./Antigravity.tar.gz;

    unpackPhase = ''
      echo "Распаковываем архив..."
      mkdir -p unpack
      tar -xzf $src -C unpack
      echo "Содержимое архива:"
      ls -l unpack
    '';

    installPhase = ''
      mkdir -p $out/opt/antigravity
      cp -r unpack/* $out/opt/antigravity/ || echo "Файлы для копирования не найдены!"

      cat > $out/start-antigravity.sh <<EOF
#!/usr/bin/env bash
exec "$out/opt/antigravity/Antigravity/bin/antigravity" "\$@"
EOF
      chmod +x $out/start-antigravity.sh

      mkdir -p $out/bin
      ln -s $out/start-antigravity.sh $out/bin/antigravity
    '';

    meta = with pkgs.lib; {
      description = "Google Antigravity IDE (agent‑first AI IDE)";
      homepage = "https://antigravityide.org/";
      license = licenses.unfree;
    };
  };
in

fhs {
  name = "antigravity-fhs";

  targetPkgs = pkgs: [
    pkgs.glib
    pkgs.glibc
    pkgs.gtk3
    pkgs.qt5.qtbase
    pkgs.libxcb
    pkgs.zlib
    pkgs.openssl
  ];

  runScript = "/opt/antigravity/Antigravity/bin/antigravity";

  multiPkgs = pkgs: [
    googleAntigravity
  ];
}

