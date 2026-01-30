# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
{
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam"
    "steam-unwrapped"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.android_sdk.accept_license = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
	  <home-manager/nixos>
	  ./greetd.nix
    ];
    programs.zsh.enable=true;
   users.users.ash.shell = pkgs.zsh;


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages;
  # hardware.opengl.enable = true;
  hardware.graphics.enable = true;
  services.displayManager.sddm.wayland.enable = false;
  services.displayManager.sddm.enable = false;
#   services.greetd.enable = true;
# services.greetd.settings = {
#   default_session = {
#     command = "${pkgs.greetd.gtkgreet}/bin/gtkgreet";
#     user = "greeter";
#   };
# };

# boot.kernelParams = ["resume_offset=21551104"];

boot.resumeDevice = "/dev/disk/by-uuid/7488fe69-dec5-4350-bfe7-316b3e14ad33";
virtualisation.libvirtd.enable = true;
boot.extraModulePackages = [ config.boot.kernelPackages.v4l2loopback ];
boot.kernelModules = [ "v4l2loopback" ];
boot.extraModprobeConfig = ''
  options v4l2loopback exclusive_caps=1 card_label="DroidCam"
'';



powerManagement.enable = true;

swapDevices = [
  {
    device = "/var/lib/swapfile";
    size = 16 * 1024; # 32GB in MB
  }
];

  services.power-profiles-daemon.enable = true;
  # Suspend first then hibernate when closing the lid
  services.logind.lidSwitch = "suspend-then-hibernate";
  # Hibernate on power button pressed
  services.logind.powerKey = "hibernate";
  services.logind.powerKeyLongPress = "poweroff";

  # Suspend first
  boot.kernelParams = ["resume_offset=21551104" "mem_sleep_default=deep"];

  # Define time delay for hibernation
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';
  programs.xss-lock = {
  enable = true;
  lockerCommand = "${pkgs.swaylock-effects}/bin/swaylock --clock --indicator --datestr '%A %H:%M'";
};

programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
};

  services.displayManager.defaultSession = "hyprland";

systemd.services.lock-on-sleep = {
  description = "Lock screen before sleep";
  before = [ "sleep.target" ];
  wantedBy = [ "sleep.target" ];
  serviceConfig = {
    Type = "simple";
    User = "ash"; # Replace with your username
    Environment = "DISPLAY=:0"; # Adjust if needed
    ExecStart = "${pkgs.swaylock}/bin/swaylock -f";
  };
};



  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Europe/Paris";



  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
   # services.xserver.enable = true;
   # services.xserver.windowManager.i3.enable = true;
   # services.xserver.displayManager.lightdm.enable = true;
programs.hyprland.enable = true;

xdg.portal.enable = true;
xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

environment.sessionVariables = {
  NIXOS_OZONE_WL = "1"; # For Electron apps to support Wayland
};

hardware.bluetooth = {
  enable = true;
  powerOnBoot = true;
  settings = {
    General = {
      Experimental = true; # Show battery charge of Bluetooth devices
    };
};
};
  

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
   # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
   services.libinput.enable = true;
	services.upower.enable = true;        # enable upower daemon<<

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.ash = {
     isNormalUser = true;
     extraGroups = [ "wheel" "libvirtd" "kvm" "video"]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
   };

   programs.firefox.enable = true;
services.interception-tools = {
  enable = true;
  plugins = [ pkgs.interception-tools-plugins.caps2esc ];
  udevmonConfig = ''
    - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
      DEVICE:
        EVENTS:
          EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
  '';
};

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     # neovim
     firefox
     # alacritty
     kitty
     git
     hyprland
     waybar
     # dunst
     # TODO: restore dunst
     xwayland
     wl-clipboard
     rofi-wayland
     hyprpaper
     gnumake
     gcc
     clang
     polkit_gnome
     unzip
     upower
	interception-tools
	wl-clipboard
	swaylock

  (pkgs.androidenv.emulateApp {
    name = "emulate-MyAndroidApp";
    platformVersion = "33";
    abiVersion = "x86_64";
    systemImageType = "google_apis_playstore";
  })

   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  # services.displayManager.sddm.enable = true;
# services.displayManager.defaultSession = "hyprland";

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
