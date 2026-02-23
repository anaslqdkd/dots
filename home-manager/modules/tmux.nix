{ pkgs, ... }:
{
	programs.tmux = {
		enable = true;
		mouse = true;
		prefix = "C-Space";
		baseIndex = 1;
		terminal = "xterm-256color";
		
		extraConfig = ''
			set -as terminal-features ",*:RGB"
			set -g default-terminal "tmux-256color"
			
			# Status bar on bottom
			set-option -g status-position bottom
			
			# Unbind default prefix
			unbind C-b
			bind C-Space send-prefix
			
			# Vim style pane selection
			bind h select-pane -L
			bind j select-pane -D 
			bind k select-pane -U
			bind l select-pane -R
			
			# Start panes at 1
			set -g pane-base-index 1
			set-window-option -g pane-base-index 1
			set-option -g renumber-windows on
			
			# Use Alt-arrow keys without prefix key to switch panes
			bind -n M-Left select-pane -L
			bind -n M-Right select-pane -R
			bind -n M-Up select-pane -U
			bind -n M-Down select-pane -D
			
			# Shift arrow to switch windows
			bind -n S-Left  previous-window
			bind -n S-Right next-window
			
			# Shift Alt vim keys to switch windows
			bind -n M-h previous-window
			bind -n M-l next-window
			
			# Set vi-mode
			set-window-option -g mode-keys vi
			
			# Vi-mode keybindings
			bind-key -T copy-mode-vi v send-keys -X begin-selection
			bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
			bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
			
			# Split windows in current path
			bind '"' split-window -v -c "#{pane_current_path}"
			bind % split-window -h -c "#{pane_current_path}"

		'';

		plugins = with pkgs.tmuxPlugins; [
			sensible
			vim-tmux-navigator
			yank
			{
				plugin = rose-pine;
				extraConfig = ''
					set -g @rose_pine_variant 'main'
					set -g @rose_pine_date_time '%d/%m/%Y %H:%M'
					set -g @rose_pine_directory 'on'
				'';
			}
		];
	};
}
