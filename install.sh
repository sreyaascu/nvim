#!/bin/bash

echo "🚀 Setting up Neovim config with Packer..."

# Step 1: Link repo to ~/.config/nvim if not already
if [ ! -L "$HOME/.config/nvim" ]; then
    echo "🔗 Linking current directory to ~/.config/nvim"
    rm -rf "$HOME/.config/nvim"
    ln -s "$(pwd)" "$HOME/.config/nvim"
fi

# Step 2: Install packer.nvim if not already installed
PACKER_PATH="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [ ! -d "$PACKER_PATH" ]; then
    echo "📦 Installing packer.nvim..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_PATH"
fi

# Step 3: Trigger plugin install
echo "🧠 Installing plugins using Packer..."
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

echo "✅ All done! Launch Neovim with `nvim` to enjoy your setup."

