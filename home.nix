{ config, pkgs, ... }:

{
  home.username = "ruwbine";
  home.homeDirectory = "/home/ruwbine";

  home.packages = with pkgs; [
    obsidian
    spotify
    telegram-desktop
    vscode
  ];

  programs.git = {
    enable = true;
    userName = "ruwbine";
    userEmail = "kurthamachi@mail.ru";
  };

  programs.zsh.enable = true;
  programs.starship.enable = true;

  # Useful environment variables
  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.stateVersion = "24.11";
}

