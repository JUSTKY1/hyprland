{ config, pkgs, lib, ... }:
{
services.xserver.enable = true;

services.xserver.displayManager.lightdm.enable = true;

services.xserver.displayManager.autoLogin.enable = true;

services.xserver.displayManager.autoLogin.user = "justin";

services.xserver.displayManager.defaultSession = "hyprland";

    security.pam.services.gtklock = {};

  environment.systemPackages = with pkgs; [
  libsForQt5.sddm
  ];

  }
