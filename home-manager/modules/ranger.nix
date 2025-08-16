{ pkgs, ... }:
{
  programs.ranger = {
    enable = true;
    extraConfig = ''
      set editor nvim
      set visual_editor nvim
    '';
  };
}
