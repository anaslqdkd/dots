{ pkgs, ... }:
{
  gtk = {
    enable = true;
    font = {
      name = "JetBrains Mono NL";
      size = 11;
    };
	    theme = {
      name = "adw-gtk3";
      package = pkgs.adw-gtk3;
    };
  };
}
