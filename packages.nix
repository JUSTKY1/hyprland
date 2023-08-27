{ config, pkgs, lib, ... }:
{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
   environment.systemPackages = with pkgs; [
     vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
     wget
     dunst
     brightnessctl
     looking-glass-client
     git
     xdg-desktop-portal-gtk
     xdg-utils
     qt6.qtwayland
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
     lutris
     pipewire
     pulseaudio
     polkit
     polkit_gnome
     protonvpn-gui
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
     blueman
     neovim
     libsForQt5.kdeconnect-kde
   ];
   
    # KDE-Connect
  programs.kdeconnect.enable = true;
  
   # Steam Devices
   hardware.steam-hardware.enable = true;
   
     # Steam 
    programs.steam.enable = true;  
   
    # Waybar
   programs.waybar.enable = true;
   
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
