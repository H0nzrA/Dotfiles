#!/usr/bin/env bash

# Color section
c_red="\033[31m"
c_green="\033[32m"
c_yellow="\033[33m"
c_blue="\033[34m"
c_magenta="\033[35m"
c_cyan="\033[36m"
c_reset="\033[0m"

# Path section
s_path=$(pwd)
s_lib_path="$s_path/lib"
s_nvim_path="$s_path/nvim"
s_zsh_path="$s_path/zsh"

# Lib section .sh file
lib_check_d="$s_lib_path/check_dependencies.sh"

f_backup="$HOME/.backup"

function	check_dependencies()
{
	"$lib_check_d"
}


function	run()
{
	echo -e "${c_green}>>>>>>>>>>	Installing Dotfiles	<<<<<<<<<<${c_reset}"

	check_dependencies
}

run
