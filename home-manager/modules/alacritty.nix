{ pkgs, ... }:
let 
	colorscheme = import ./colorscheme.nix;
in
{
  programs.alacritty = {
    enable = true;

    settings = {
      font = {
        normal.family = "JetBrains Mono NL";
        size = 12.0;
      };
      window = {
        opacity = 0.9;
      };
    }//colorscheme;
  };
}
