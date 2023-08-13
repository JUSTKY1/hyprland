{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "justin";
  home.homeDirectory = "/home/justin";

 #Gtk 
    gtk = {
      enable = true;
        iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };

      gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };

      gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
      '';
    };
    
  };
  
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";
  
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
