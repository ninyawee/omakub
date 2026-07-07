#!/bin/bash

# Keep Ubuntu/GNOME's native dock, tray, tiling, and desktop-icons extensions on.
# Fresh installs already have these enabled; this also re-enables them on machines
# that ran an older Omakub which turned them off in favor of third-party extensions.
gnome-extensions enable tiling-assistant@ubuntu.com
gnome-extensions enable ubuntu-appindicators@ubuntu.com
gnome-extensions enable ubuntu-dock@ubuntu.com
gnome-extensions enable ding@rastersoft.com
