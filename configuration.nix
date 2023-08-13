# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running `nixos-help`).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
   programs.nm-applet.enable = true; 
  # Set your time zone.
   time.timeZone = "America/Los_Angeles";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
   i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkbOptions in tty.
  # };
  # Enable Flakes & Nix-Command
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  # Hyperland WIndow Manager Programs
   programs.hyprland.enable = true;
   programs.hyprland.xwayland.enable = true;
 
  # Start USB Auto-Mount

   services.gvfs.enable = true;
  
  # Polkit
   security.polkit.enable = true;  
   services.gnome.gnome-keyring.enable = true;

  # Bluetooth
   hardware.bluetooth.enable = true;
 
  # Sound
   services.pipewire.audio.enable = true;
   services.pipewire.enable = true;
   services.pipewire.wireplumber.enable = true;
   services.pipewire.pulse.enable = true;
   services.pipewire.jack.enable = true;
   services.pipewire.alsa.enable = true;
   services.pipewire.alsa.support32Bit = true;
   

  # Fonts Dir-Enable
   fonts.fontDir.enable = true;
   fonts.packages = with pkgs; [  
        nerdfonts
        font-awesome
    ]; 
  
  # Icons
   xdg.icons.enable = true;    

  # Bash
   programs.bash.enableCompletion = true;
   programs.nix-index.enableBashIntegration = true;
  # Waybar
   programs.waybar.enable = true;

  # environment etc
    environment.etc = {
	"xdg/gtk-3.0" .source = ./gtk-3.0;
    };
  
  # Auto-Login
    services.getty.autologinUser = "justin";
    
   # services.xserver.displayManager.autoLogin.enable = true;  
  
  # Allow Unfree Software
    nixpkgs.config.allowUnfree = true;

  # D-Bus
    services.dbus.enable = true;
     xdg.portal = {
        enable = true;
        extraPortals = [ 
        pkgs.xdg-desktop-portal-gtk
        ];
     }; 
  
  # Configure keymap in X11
   services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;
  
  # Steam 
    programs.steam.enable = true;  

  # Enable sound.
   sound.enable = true;
  # hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
   services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.justin = {
     isNormalUser = true;
     extraGroups = [ "wheel" "networkmanager" "video" "audio" "kvm" ]; # Enable ‘sudo’ for the user.
  #   packages = with pkgs; [
  #     firefox
  #     tree
  #   ];
   };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     catppuccin-gtk
     dunst
     brightnessctl
     git
     hyprland
     hyprland-protocols
     hyprland-share-picker
     xdg-desktop-portal-hyprland
     xdg-desktop-portal-gtk
     xdg-utils
     qt6.qtwayland
     qt6.full
     xfce.thunar
     xfce.thunar-volman
     xfce.tumbler
     xsettingsd
     gvfs
     alacritty
     kitty
     firefox
     gtklock
     rofi-wayland
     swaybg
     seatd
     steam
     pipewire
     pulseaudio
     polkit
     libsForQt5.polkit-kde-agent
     pavucontrol
     papirus-icon-theme
     gnome.gedit
     gnome.gnome-themes-extra
     gtk-engine-murrine
     gtk3
     wireplumber 
     neofetch
     waybar
     xwayland
     networkmanagerapplet
   ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
   programs.gnupg.agent = {
     enable = true;
     enableSSHSupport = true;
   };

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
   system.copySystemConfiguration = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "nixos-unstable"; # Did you read the comment?

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  
   #Overlays
    #Waybar wlr/Workspaces
    nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
    ];
  
}

