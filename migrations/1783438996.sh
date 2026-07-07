#!/bin/bash

# Drop Omakub's dock/tiling/blur/workspace-indicator/monitor extension stack and
# restore Ubuntu 26.04/GNOME 50's native dock, tray icons, tiling, and desktop icons.
for ext in tactile@lundal.io just-perfection-desktop@just-perfection blur-my-shell@aunetx space-bar@luchrioh undecorate@sun.wxg@gmail.com tophat@fflewddur.github.io AlphabeticalAppGrid@stuarthayhurst; do
  if gnome-extensions list | grep -q "^$ext$"; then
    gnome-extensions uninstall "$ext"
  fi
done

gnome-extensions enable tiling-assistant@ubuntu.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com
gnome-extensions enable ubuntu-dock@ubuntu.com
gnome-extensions enable ding@rastersoft.com

# Logout
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt
