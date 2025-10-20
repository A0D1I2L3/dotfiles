#!/usr/bin/env bash

# Exit on error
set -euo pipefail

# Get the focused monitor name
focused_monitor=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true).name')

# Validate that we got a monitor name
if [[ -z "$focused_monitor" ]]; then
    echo "Error: Could not determine focused monitor" >&2
    exit 1
fi

# Validate brightness argument
if [[ -z "${1:-}" ]]; then
    echo "Error: Brightness value required" >&2
    echo "Usage: $0 <brightness_value>" >&2
    exit 1
fi

# Call swayosd-client with the brightness value
swayosd-client --monitor "$focused_monitor" --brightness "$1"
