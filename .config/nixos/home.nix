{ pkgs, ... }:

{
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    zsh
    gcc
    clang
    cl
    zig

  ];

  programs.git.enable = true;
  programs.zsh.enable = true;
}

