#!/usr/bin/env bash

echo ">>>>>>>>>>	Checking dependencies installation	<<<<<<<<<<"

# Color section
c_red="\033[31m"
c_green="\033[32m"
c_yellow="\033[33m"
c_blue="\033[34m"
c_magenta="\033[35m"
c_cyan="\033[36m"
c_reset="\033[0m"

is_neovim_install=0
is_node_install=0

function	check_neovim()
{
	echo ""
	echo -e "${c_magenta}- Check Neovim ...${c_reset}"

	if command -v nvim > /dev/null 2>&1; then
		is_neovim_install=1
		echo -e "${c_green}Neovim is installed${c_reset}"
		nvim --version | head -n 1
	
	else
		is_neovim_install=0
		echo "${c_yellow}Neovim is not found${c_reset}"
	fi

}

function	install_neovim()
{
	echo -e "${c_blue}Do you want to install neovim? (y/n) ${c_reset}"
	read -r choice
	choice=${choice,,}

	if [[ "$choice" != "y" && "$choice" != "yes" ]]; then
		echo -e "${c_yellow}Abort installation!!${c_reset}"
		exit 1
	fi

	local bin_path="$HOME/.local/bin"

	printf "%s\n" "What to way to install neovim?" \
		"1. Apt repository (sometimes older version (os dependence))" \
		"2. Snap command (is snap is installed | always the latest version)" \
		"3. Link download and binaries in ~/.local/bin" \
		"q. Abort installation"
	read -rp "Enter choice: " choice

	case "$choice" in
		1)
			sudo apt install neovim
			;;

		2)
			sudo snap install neovim --classic
			;;

		3)
			curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
            tar -xzf nvim-linux-x86_64.tar.gz
            mkdir -p "$bin_path"
            mv nvim-linux-x86_64 "$bin_path/nvim"
            export PATH="$PATH:$bin_path/nvim/bin"
			;;
		
		q|Q)
			echo -e "${c_yellow}Abort installation!!${c_reset}"
			return 1
			;;

		*)
			echo -e "${c_yellow}Invalid option!!${c_reset}"
			return 1
			;;

	esac

	check_neovim
	if [[ "$is_neovim_install" -ne 1 ]]; then
		echo -e "${c_red}Failed to install neovim${c_reset}"
		return 1

	fi
}

function	check_node()
{
	echo ""
	echo -e "${c_magenta}- Check Node ...${c_reset}"

	if command -v node > /dev/null 2>&1; then
		is_node_install=1
		echo -e "${c_green}Node is installed${c_reset}"
		node -v | head -n 1

		if command -v npm > /dev/null 2>&1; then
			is_node_install=1
			echo -e "${c_green}npm command found${c_reset}"
			npm -v | head -n 1

		else
			is_node_install=0
			echo -e "${c_red}npm command not found, need npm for the installation"

		fi
		
	else
		is_node_install=0
		echo "${c_yellow}Node is not found${c_reset}"
	fi
}

function	install_node()
{
	echo -e "${c_blue}Do you want to install node-npm? (y/n) ${c_reset}"
	read -r choice
	choice=${choice,,}

	if [[ "$choice" != "y" && "$choice" != "yes" ]]; then
		echo -e "${c_yellow}Abort installation!!${c_reset}"
		return 1
	fi

	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash

	export NVM_DIR="${NVM_DIR:-$HOME/.config/nvm}"
	[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

	nvm install --lts
	nvm use --lts

	check_node
	if [[ "$is_node_install" -ne 1 ]]; then
		echo -e "${c_red}Failed to install node-npm${c_reset}"
		return 1

	fi
}

function	check_dependencies()
{
	check_neovim
	check_node
}

function	install_dependencies()
{
	if [[ "$is_neovim_install" -ne 1 ]]; then
		install_neovim
	fi

	if [[ "$is_node_install" -ne 1 ]]; then
		install_node
	fi
}

function	run()
{
	check_dependencies
	install_dependencies
}

run

