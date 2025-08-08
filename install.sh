#!/bin/bash

# Step 1: Ensure Packer is installed
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_PATH" ]; then
  echo "Installing packer.nvim..."
  git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
else
  echo "Packer is already installed."
fi

# Step 2: Install plugins via Packer using headless nvim
echo "Installing plugins via packer..."
nvim --headless +PackerSync +qa

echo "✅ Done! You can now open nvim normally."

