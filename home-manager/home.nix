{ lib, pkgs, zen, ... }:
{
	  imports =
    [
	./modules/packages.nix
	./modules/alacritty.nix
	./modules/zsh.nix
	./modules/gtk.nix
	./modules/tmux.nix
	./modules/ranger.nix
	./modules/zathura.nix
	./modules/neovim.nix

    ];
  home = {
    username = "ash";
    homeDirectory = "/home/ash";
    stateVersion = "25.05";
	sessionVariables = {
		EDITOR = "nvim";
		VISUAL = "nvim";
	};
  };
  fonts.fontconfig.enable = true;
  home.activation.createTmuxResurrectDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  mkdir -p "$HOME/.tmux/resurrect"
'';

  systemd.user.services.wlsunset = {
    Unit = {
      Description = "wlsunset - Day/night gamma adjustment";
      After = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l <latitude> -L <longitude> -t 4000 -T 6500";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };
}


# TODO: add git config
