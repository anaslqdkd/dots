{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
	  plugins = with pkgs.tmuxPlugins; [ resurrect continuum];
    extraConfig = ''
	set -as terminal-features ",*:RGB"
	set -g default-terminal "tmux-256color"
	set -g history-limit 10000
	set -g status-bg black
	set -g status-fg green 
	set -g base-index 1
	set -g @plugin 'tmux-plugins/tmux-resurrect'
	set -g @plugin 'tmux-plugins/tmux-continuum'
	set -g @plugin 'tmux-plugins/tpm'
	set -g @resurrect-strategy-vim 'session'
	setw -g pane-base-index 1
	set -g @continuum-restore 'on'
	set -g @continuum-boot on
	set-window-option -g mode-keys vi
	bind h select-pane -L
	bind j select-pane -D
	bind k select-pane -U
	bind l select-pane -R

	bind h previous-window
	set -s escape-time 0
	bind l next-window
	run-shell ${pkgs.tmuxPlugins.resurrect}/share/tmux-plugins/resurrect/resurrect.tmux
	run-shell ${pkgs.tmuxPlugins.continuum}/share/tmux-plugins/continuum/continuum.tmux
	run-shell ${pkgs.tmuxPlugins.sensible}/share/tmux-plugins/sensible/sensible.tmux
	run-shell ${pkgs.tmuxPlugins.open}/share/tmux-plugins/open/open.tmux
	run-shell ${pkgs.tmuxPlugins.yank}/share/tmux-plugins/yank/yank.tmux
	set -g @resurrect-strategy-nvim 'session' 
	set -g @resurrect-capture-pane-contents 'on'	
	unbind C-b
	set -g prefix C-a
	bind r command-prompt -I "#W" "rename-session '%%'"
	resurrect_dir="$HOME/.tmux/resurrect"
	set -g @resurrect-dir $resurrect_dir
	set -g @resurrect-hook-post-save-all 'target=$(readlink -f $resurrect_dir/last); sed "s| --cmd .*-vim-pack-dir||g; s|/etc/profiles/per-user/$USER/bin/||g; s|/home/$USER/.nix-profile/bin/||g" $target | sponge $target'
	set-option -g default-shell "~/.nix-profile/bin/zsh"
    set -g mouse on
	set -g history-limit 100000
	run '~/.tmux/plugins/tpm/tpm'
    '';
  };
}
# TODO: file for dependencies for neovim
