{ config, pkgs, lib, ... }:
let
  configure-gtk = pkgs.writeTextFile {
    name = "configure-gtk";
    destination = "/bin/configure-gtk";
    executable = true;
    text = let
      schema = pkgs.gsettings-desktop-schemas;
      datadir = "${schema}/share/gsettings-schemas/${schema.name}";
    in ''
      export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS
      gnome_schema=org.gnome.desktop.interface
      gsettings set $gnome_schema gtk-theme 'Dracula'
    '';
  };


in
{
  environment.systemPackages = with pkgs; [
    configure-gtk
    xdg-utils # for opening default programs when clicking links
    glib # gsettings
    dracula-theme # gtk theme
    gnome3.adwaita-icon-theme  # default gnome cursors
    hyprland
    hyprland-protocols
    hyprland-share-picker
    xdg-desktop-portal-hyprland
    
  ];
  

  programs.hyprland.xwayland.enable = true;

  services.dbus.enable = true;


  # enable hyprland window manager
  programs.hyprland.enable = true;
}
