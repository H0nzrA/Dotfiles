#!/bin/bash

# Dotfiles Installation Script
# This script copies configuration files for Neovim, Kitty, and Zsh to their proper locations

# ============================================================================
# Configuration Paths
# ============================================================================
SCRIPT_DIR=$(pwd)
CONFIG_DIR="$SCRIPT_DIR/config"
ZSH_DIR="$SCRIPT_DIR/zsh"

# ============================================================================
# Color Codes
# ============================================================================
C_RESET="\033[0m"
C_RED="\033[31m"
C_GREEN="\033[32m"
C_YELLOW="\033[33m"
C_BLUE="\033[34m"

# ============================================================================
# Utility Functions
# ============================================================================

# Print colored log messages
# Usage: print_log "message" [color]
# Colors: r=red, y=yellow, g=green (default), b=blue
print_log() {
    local message="$1"
    local color_code="${2,,}"  # Convert to lowercase
    local color="$C_GREEN"

    if [[ -z "$message" ]]; then
        echo -e "${C_RED}Error: No log message provided${C_RESET}"
        return 1
    fi

    case "$color_code" in
        r) color="$C_RED" ;;
        y) color="$C_YELLOW" ;;
        b) color="$C_BLUE" ;;
        *) color="$C_GREEN" ;;
    esac

    echo -e "${color}${message}${C_RESET}"
    return 0
}

# Create a backup of existing file/directory
# Usage: backup_if_exists "path"
backup_if_exists() {
    local path="$1"
    
    if [[ -e "$path" ]]; then
        local backup_path="${path}.backup.$(date +%Y%m%d_%H%M%S)"
        if mv "$path" "$backup_path"; then
            print_log "  ↳ Backup created: $backup_path" "y"
            return 0
        else
            print_log "  ✗ Failed to create backup of $path" "r"
            return 1
        fi
    fi
    return 0
}

# ============================================================================
# Installation Functions
# ============================================================================

# Install Neovim configuration
install_nvim_config() {
    print_log "\n[Neovim Configuration]" "b"
    
    local nvim_config="$HOME/.config/nvim"
    local source_nvim="$CONFIG_DIR/nvim"

    if [[ ! -d "$source_nvim" ]]; then
        print_log "  ✗ Source Neovim config not found at $source_nvim" "r"
        return 1
    fi

    if [[ -e "$nvim_config" ]]; then
        print_log "  ⚠ Neovim config already exists at $nvim_config" "y"
        read -rp "  Do you want to backup and replace it? (y/n): " choice
        choice=${choice,,}
        
        if [[ "$choice" != "y" && "$choice" != "yes" ]]; then
            print_log "  ⊘ Skipping Neovim config installation" "y"
            return 0
        fi
        
        backup_if_exists "$nvim_config" || return 1
    fi

    # Ensure .config directory exists
    mkdir -p "$HOME/.config"

    if cp -r "$source_nvim" "$nvim_config"; then
        print_log "  ✓ Neovim config installed successfully" "g"
        return 0
    else
        print_log "  ✗ Failed to install Neovim config" "r"
        return 1
    fi
}

# Install Kitty configuration
install_kitty_config() {
    print_log "\n[Kitty Configuration]" "b"
    
    local kitty_config="$HOME/.config/kitty"
    local source_kitty="$CONFIG_DIR/kitty"

    if [[ ! -d "$source_kitty" ]]; then
        print_log "  ✗ Source Kitty config not found at $source_kitty" "r"
        return 1
    fi

    if [[ -e "$kitty_config" ]]; then
        print_log "  ⚠ Kitty config already exists at $kitty_config" "y"
        read -rp "  Do you want to backup and replace it? (y/n): " choice
        choice=${choice,,}
        
        if [[ "$choice" != "y" && "$choice" != "yes" ]]; then
            print_log "  ⊘ Skipping Kitty config installation" "y"
            return 0
        fi
        
        backup_if_exists "$kitty_config" || return 1
    fi

    # Ensure .config directory exists
    mkdir -p "$HOME/.config"

    if cp -r "$source_kitty" "$kitty_config"; then
        print_log "  ✓ Kitty config installed successfully" "g"
        return 0
    else
        print_log "  ✗ Failed to install Kitty config" "r"
        return 1
    fi
}

# Install Zsh configuration
install_zsh_config() {
    print_log "\n[Zsh Configuration]" "b"
    
    local zsh_folder="$HOME/.zsh"
    local zshrc_file="$HOME/.zshrc"
    local source_zsh_folder="$ZSH_DIR/.zsh"
    local source_zshrc="$ZSH_DIR/.zshrc"

    # Check if source files exist
    if [[ ! -d "$source_zsh_folder" && ! -f "$source_zshrc" ]]; then
        print_log "  ✗ No Zsh configuration found in $ZSH_DIR" "r"
        print_log "  ℹ Expected: $source_zsh_folder/ and/or $source_zshrc" "y"
        return 1
    fi

    # Handle .zsh folder (plugins, themes, etc.)
    if [[ -d "$source_zsh_folder" ]]; then
        if [[ -e "$zsh_folder" ]]; then
            print_log "  ⚠ .zsh folder already exists at $zsh_folder" "y"
            read -rp "  Do you want to backup and replace it? (y/n): " choice
            choice=${choice,,}
            
            if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
                backup_if_exists "$zsh_folder" || return 1
                
                if cp -r "$source_zsh_folder" "$zsh_folder"; then
                    print_log "  ✓ .zsh folder installed successfully" "g"
                else
                    print_log "  ✗ Failed to install .zsh folder" "r"
                    return 1
                fi
            else
                print_log "  ⊘ Skipping .zsh folder installation" "y"
            fi
        else
            if cp -r "$source_zsh_folder" "$zsh_folder"; then
                print_log "  ✓ .zsh folder installed successfully" "g"
            else
                print_log "  ✗ Failed to install .zsh folder" "r"
                return 1
            fi
        fi
    else
        print_log "  ℹ No .zsh folder found in source" "y"
    fi

    # Handle .zshrc file
    if [[ -f "$source_zshrc" ]]; then
        if [[ -e "$zshrc_file" ]]; then
            print_log "  ⚠ .zshrc file already exists at $zshrc_file" "y"
            read -rp "  Do you want to backup and replace it? (y/n): " choice
            choice=${choice,,}
            
            if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
                backup_if_exists "$zshrc_file" || return 1
                
                if cp "$source_zshrc" "$zshrc_file"; then
                    print_log "  ✓ .zshrc file installed successfully" "g"
                else
                    print_log "  ✗ Failed to install .zshrc file" "r"
                    return 1
                fi
            else
                print_log "  ⊘ Skipping .zshrc file installation" "y"
            fi
        else
            if cp "$source_zshrc" "$zshrc_file"; then
                print_log "  ✓ .zshrc file installed successfully" "g"
            else
                print_log "  ✗ Failed to install .zshrc file" "r"
                return 1
            fi
        fi
    else
        print_log "  ℹ No .zshrc file found in source" "y"
    fi

    return 0
}

# Install Zsh plugins and themes
install_zsh_plugins() {
    print_log "\n[Zsh Plugins & Themes]" "b"
    
    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_log "  ✗ Git is not installed. Please install git first." "r"
        return 1
    fi

    local plugins_dir="$HOME/.zsh/plugins"
    local themes_dir="$HOME/.zsh/themes"
    local install_plugins=false

    read -rp "  Do you want to install Zsh plugins and themes? (y/n): " choice
    choice=${choice,,}
    
    if [[ "$choice" != "y" && "$choice" != "yes" ]]; then
        print_log "  ⊘ Skipping plugin installation" "y"
        return 0
    fi

    install_plugins=true

    # Create directories if they don't exist
    mkdir -p "$plugins_dir"
    mkdir -p "$themes_dir"

    print_log "\n  Installing plugins..." "b"

    # Install zsh-autosuggestions
    local autosuggestions_dir="$plugins_dir/zsh-autosuggestions"
    if [[ -d "$autosuggestions_dir" ]]; then
        print_log "  ℹ zsh-autosuggestions already exists" "y"
        read -rp "  Do you want to update it? (y/n): " update_choice
        update_choice=${update_choice,,}
        
        if [[ "$update_choice" == "y" || "$update_choice" == "yes" ]]; then
            print_log "  → Updating zsh-autosuggestions..." "b"
            if git -C "$autosuggestions_dir" pull; then
                print_log "  ✓ zsh-autosuggestions updated successfully" "g"
            else
                print_log "  ✗ Failed to update zsh-autosuggestions" "r"
            fi
        else
            print_log "  ⊘ Skipping zsh-autosuggestions update" "y"
        fi
    else
        print_log "  → Cloning zsh-autosuggestions..." "b"
        if git clone https://github.com/zsh-users/zsh-autosuggestions "$autosuggestions_dir"; then
            print_log "  ✓ zsh-autosuggestions installed successfully" "g"
        else
            print_log "  ✗ Failed to install zsh-autosuggestions" "r"
        fi
    fi

    # Install zsh-syntax-highlighting
    local highlighting_dir="$plugins_dir/zsh-syntax-highlighting"
    if [[ -d "$highlighting_dir" ]]; then
        print_log "  ℹ zsh-syntax-highlighting already exists" "y"
        read -rp "  Do you want to update it? (y/n): " update_choice
        update_choice=${update_choice,,}
        
        if [[ "$update_choice" == "y" || "$update_choice" == "yes" ]]; then
            print_log "  → Updating zsh-syntax-highlighting..." "b"
            if git -C "$highlighting_dir" pull; then
                print_log "  ✓ zsh-syntax-highlighting updated successfully" "g"
            else
                print_log "  ✗ Failed to update zsh-syntax-highlighting" "r"
            fi
        else
            print_log "  ⊘ Skipping zsh-syntax-highlighting update" "y"
        fi
    else
        print_log "  → Cloning zsh-syntax-highlighting..." "b"
        if git clone https://github.com/zsh-users/zsh-syntax-highlighting "$highlighting_dir"; then
            print_log "  ✓ zsh-syntax-highlighting installed successfully" "g"
        else
            print_log "  ✗ Failed to install zsh-syntax-highlighting" "r"
        fi
    fi

    print_log "\n  Installing themes..." "b"

    # Install Powerlevel10k
    local p10k_dir="$themes_dir/powerlevel10k"
    if [[ -d "$p10k_dir" ]]; then
        print_log "  ℹ Powerlevel10k already exists" "y"
        read -rp "  Do you want to update it? (y/n): " update_choice
        update_choice=${update_choice,,}
        
        if [[ "$update_choice" == "y" || "$update_choice" == "yes" ]]; then
            print_log "  → Updating Powerlevel10k..." "b"
            if git -C "$p10k_dir" pull; then
                print_log "  ✓ Powerlevel10k updated successfully" "g"
            else
                print_log "  ✗ Failed to update Powerlevel10k" "r"
            fi
        else
            print_log "  ⊘ Skipping Powerlevel10k update" "y"
        fi
    else
        print_log "  → Cloning Powerlevel10k..." "b"
        if git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$p10k_dir"; then
            print_log "  ✓ Powerlevel10k installed successfully" "g"
        else
            print_log "  ✗ Failed to install Powerlevel10k" "r"
        fi
    fi

    # Ask if user wants to configure Powerlevel10k
    if [[ -d "$p10k_dir" ]] && [[ "$install_plugins" == true ]]; then
        print_log "\n  ℹ Powerlevel10k configuration" "y"
        print_log "  Note: You'll need to restart your terminal and run 'p10k configure'" "y"
        print_log "  to set up Powerlevel10k after installation is complete." "y"
    fi

    return 0
}

# Configure Kitty as default terminal
configure_kitty_default() {
    print_log "\n[Kitty Default Terminal]" "b"
    
    # Check if update-alternatives is available (Debian/Ubuntu based systems)
    if ! command -v update-alternatives &> /dev/null; then
        print_log "  ℹ update-alternatives not found (not a Debian-based system?)" "y"
        print_log "  ⊘ Skipping default terminal configuration" "y"
        return 0
    fi

    read -rp "  Do you want to set Kitty as the default terminal? (y/n): " choice
    choice=${choice,,}

    if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
        print_log "  → Running update-alternatives for x-terminal-emulator..." "b"
        sudo update-alternatives --config x-terminal-emulator
    else
        print_log "  ⊘ Skipping default terminal configuration" "y"
    fi
}

# ============================================================================
# Main Installation Process
# ============================================================================

main() {
    print_log "\n╔════════════════════════════════════════════════════════════╗" "b"
    print_log "║          Dotfiles Installation Script                     ║" "b"
    print_log "╚════════════════════════════════════════════════════════════╝" "b"
    
    print_log "\nInstallation directory: $SCRIPT_DIR" "b"
    
    # Verify source directories exist
    local missing_sources=0
    
    if [[ ! -d "$CONFIG_DIR" ]]; then
        print_log "\n✗ Config directory not found: $CONFIG_DIR" "r"
        missing_sources=1
    fi
    
    if [[ ! -d "$ZSH_DIR" ]]; then
        print_log "\n✗ Zsh directory not found: $ZSH_DIR" "r"
        missing_sources=1
    fi
    
    if [[ $missing_sources -eq 1 ]]; then
        print_log "\n✗ Installation aborted due to missing source directories" "r"
        exit 1
    fi
    
    # Run installation functions
    install_nvim_config
    install_kitty_config
    install_zsh_config
    install_zsh_plugins
    configure_kitty_default
    
    # Final message
    print_log "\n╔════════════════════════════════════════════════════════════╗" "b"
    print_log "║          Installation Complete!                           ║" "b"
    print_log "╚════════════════════════════════════════════════════════════╝" "b"
    print_log "\n📋 Next Steps:" "b"
    print_log "  1. Restart your terminal or run: source ~/.zshrc" "y"
    print_log "  2. If you installed Powerlevel10k, run: p10k configure" "y"
    print_log "  3. Enjoy your new dotfiles! 🎉\n" "g"
}

# ============================================================================
# Script Execution
# ============================================================================

main "$@"
