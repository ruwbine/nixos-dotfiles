{ pkgs ? import <nixpkgs> {} }:

pkgs.buildFHSUserEnv {
  name = "antigravity-fhs";

  # Библиотеки, которые нужны приложению
  targetPkgs = pkgs: [
    pkgs.glib
    pkgs.glibc
    pkgs.gtk3
    pkgs.qt5.qtbase  # если приложение использует Qt
    pkgs.libxcb
    pkgs.zlib
    pkgs.openssl
  ];

  # Скрипт запуска внутри окружения
  runScript = "/opt/antigravity/Antigravity/bin/antigravity";

  # Подключаем наш unpacked tar
  multiPkgs = pkgs: [
    (pkgs.callPackage ./google-antigravity.nix {})
  ];
}

