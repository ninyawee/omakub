#!/bin/bash

# Reboot to pick up changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo systemctl reboot -i || true
