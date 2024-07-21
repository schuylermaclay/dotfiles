#!/bin/bash

# Get the current key repeat settings
key_repeat_initial=$(defaults read -g InitialKeyRepeat)
key_repeat_secondary=$(defaults read -g KeyRepeat)

# Print the key repeat settings
echo "Initial Key Repeat: $key_repeat_initial"
echo "Key Repeat        : $key_repeat_secondary"
