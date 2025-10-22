{ lib, pkgs, zen, ... }:
let
nvim-spell-fr-utf8-dictionary = builtins.fetchurl {
  url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.spl";
  sha256 = "abfb9702b98d887c175ace58f1ab39733dc08d03b674d914f56344ef86e63b61";
};

nvim-spell-fr-utf8-suggestions = builtins.fetchurl {
  url = "http://ftp.vim.org/vim/runtime/spell/fr.utf-8.sug";
  sha256 = "0294bc32b42c90bbb286a89e23ca3773b7ef50eff1ab523b1513d6a25c6b3f58";
};

nvim-spell-fr-latin1-dictionary = builtins.fetchurl {
  url = "http://ftp.vim.org/vim/runtime/spell/fr.latin1.spl";
  sha256 = "086ccda0891594c93eab143aa83ffbbd25d013c1b82866bbb48bb1cb788cc2ff";
};

nvim-spell-fr-latin1-suggestions = builtins.fetchurl {
  url = "http://ftp.vim.org/vim/runtime/spell/fr.latin1.sug";
  sha256 = "5cb2c97901b9ca81bf765532099c0329e2223c139baa764058822debd2e0d22a";
};
in
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
      ExecStart = "${pkgs.wlsunset}/bin/wlsunset -l 48 -L 2 -t 4000 -T 6500";
      Restart = "on-failure";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
  };

}


# TODO: add git config
# TODO: add power management
