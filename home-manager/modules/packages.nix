{ pkgs, zen, ... }:
{
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;
  home.packages = with pkgs; [
    # Shell & CLI
    zsh
    htop
    tmux
    bat
    ripgrep
    fd
    ranger

    # Terminal & Fonts
    alacritty
    jetbrains-mono
    nerd-fonts.symbols-only

    # Zsh Plugins
    zsh-autosuggestions
    zsh-vi-mode

    # Wayland & Utilities
    vesktop
    redshift
    pavucontrol
    grim
    slurp
    swappy
    pamixer
    lxappearance
    hyprpaper
    hyprlock
    brightnessctl
    networkmanagerapplet
    wofi
    waybar
    swaylock-effects

    # Bluetooth
    bluez
    blueman
    rofi-bluetooth

    # Apps & Tools
    keepassxc
    pywal
    lua-language-server
    imv
    chafa
    adw-gtk3
    zathura
	interception-tools
	telegram-desktop
	moreutils
	tmuxPlugins.sensible
    tmuxPlugins.continuum
    tmuxPlugins.resurrect
    tmuxPlugins.open
    tmuxPlugins.yank
    # python310Packages.pyqt6

# pour mind
	mesa
	# python310
	libGL
  # X11 and OpenGL dependencies
  libxkbcommon

  # Font and image support
  fontconfig
  freetype
  libpng
  libjpeg
  libGLU

  # Standard C++ and C libraries
  gcc
  glib
  zlib

# neovim
  lua-language-server
  pyright
  rust-analyzer
  texlab
  clang-tools

	zen
	chromium

	mpvpaper
	mpv
	jq

	upower
	wlsunset
	socat
	tree-sitter
	fzf
	vimPlugins.neorg
	stylua

# latex
texlive.combined.scheme-full
typst
tinymist
websocat

direnv
dancing-script
eb-garamond

nodejs_24
black
google-java-format
sqlite
xorg.xkill
pandoc
python313
python313Packages.dbus-python
networkmanagerapplet
networkmanager_dmenu
sqlitebrowser
libreoffice-qt6-fresh
python313Packages.pip
lua52Packages.luasql-sqlite3
unityhub


wasistlos
foliate
unrar
android-tools
androidsdk
android-studio



  ];
}
