#!/bin/bash



s_path=$(pwd)
s_config_path="$s_path/config"
s_zsh_path="$s_path/zsh"

# Color section
c_reset="\033[0m"
c_red="\033[31m"
c_green="\033[32m"
c_yellow="\033[33m"


function	print_log()
{
	local color="$c_green"

	if [[ -z "$1" ]]; then
		echo -e "No logs add"
		return 1
	fi

	color_val=${2,,}
	if [[ "$color_val" == "r" ]]; then
		color="$c_red"
	elif [[ "$color_val" == "y" ]]; then
		color="$c_yellow"
	else
		color="$c_green"
	fi

	echo -e "${color}"
	echo -e "$1"
	echo -e "${c_reset}"
	return 0
}

function	copy_config()
{
	local is_kitty=0
	local is_nvim=0

	# ===== Neovim section =====
	if [[ -e "$HOME/.config/nvim" ]]; then
		print_log "Neovim config already exist, abort copy" "y"
		is_nvim=1
	fi

	# ===== Kitty section =====
	if [[ -e "$HOME/.config/kitty" ]]; then
		print_log "Kitty config already exist, abort copy" "y"
		is_kitty=1
	fi

	# =============================
	if [[ "$is_nvim" -eq 0 ]]; then
		if cp -r "$s_config_path/nvim" "$HOME/.config/"; then
			print_log "-> Neovim config copied successfully" "g"
		else
			print_log "-> Failed to copy Neovim config" "r"
		fi
	fi

	if [[ "$is_kitty" -eq 0 ]];then
		if cp -r "$s_config_path/kitty" "$HOME/.config/"; then
			print_log "-> Kitty config copied successfully" "g"
		else
			print_log "-> Failed to copy Kitty config" "r"
		fi
	fi
}

function	copy_zsh()
{
	local folder_zsh=0
	local file_zsh=0

	if [[ -d "$HOME/.zsh" ]]; then
		folder_zsh=1
		print_log ".zsh folder already exist" "y"
	fi
	
	if [[ -f "$HOME/.zshrc" ]]; then
		file_zsh=1
		print_log ".zshrc file already exist" "y"
	fi

	if [[ "$folder_zsh" -eq 0 ]]; then
		if cp -r "$s_zsh_path/.zsh" "$HOME/.zsh"; then
			print_log "-> ZSH plugins copied successfully" "g"
		else
			print_log "-> Failed to copy zsh plugins" "r"
		fi
	fi

	if [[ "$file_zsh" -eq 0 ]]; then
		if cp "$s_zsh_path/.zshrc" "$HOME/"; then
			print_log "-> .zshrc copied successfully" "g"
		else
			print_log "-> Failed to copy .zshrc file" "r"
		fi
	fi
}

function	copy_file()
{
	copy_config
	copy_zsh
}


function	run()
{
	print_log ">>>>>>>>>>	Installation of Dotfiles	<<<<<<<<<<"

	copy_file
}

run
