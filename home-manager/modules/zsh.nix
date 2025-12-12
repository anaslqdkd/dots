{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
	plugins = [
	{
		name = "zsh-nix-shell";
		src = pkgs.fetchFromGitHub {
			owner = "chisui";
			repo = "zsh-nix-shell";
			rev = "v0.8.0";
			sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
		};
	}
	];
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
    enableCompletion = true;
    syntaxHighlighting.enable = true;
	  history = {
		size = 10000;
		save = 10000;
		ignoreDups = true;
		share = true;
	  };
	  
    initExtra = ''
      # Enable zsh-autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

      # Optional: move suggestion color to something more visible
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
	        # Enable zsh-vi-mode
 	export LD_LIBRARY_PATH="$HOME/.nix-profile/lib:$LD_LIBRARY_PATH"
      source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
	  [ -f "$HOME/.cache/wal/colors.sh" ] && source "$HOME/.cache/wal/colors.sh"
	  eval "$(direnv hook zsh)"
	     setopt APPEND_HISTORY
		   setopt INC_APPEND_HISTORY
		   setopt SHARE_HISTORY



    '';
	shellAliases = {
	":q" = "exit";
	"dotfiles" = "/run/current-system/sw/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME";
  };
  };
}
