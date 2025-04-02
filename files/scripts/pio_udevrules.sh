#!/usr/bin/env bash

set -euo pipefail

# Udev rules for Platformio
wget https://raw.githubusercontent.com/platformio/platformio-core/develop/platformio/assets/system/99-platformio-udev.rules -O /etc/udev/rules.d/99-platformio.rules
chmod 0644 /etc/udev/rules.d/99-platformio.rules
