#!/bin/bash

# Logout to pickup changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo systemctl reboot -i || true
