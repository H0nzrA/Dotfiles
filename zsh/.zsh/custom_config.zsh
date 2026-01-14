# ===== Custome config =====
export PATH="$HOME/.local/bin:$PATH"

function sudo()
{
	figlet "Andrianina" | lolcat
	command sudo $@
}

function restore_nvim()
{
	rm -rf ~/.local/share/nvim/
	rm -rf ~/.local/state/nvim/
	rm -rf ~/.cache/nvim/
}

function ventoy()
{
	if [[ -z "$1" ]]; then
		echo "Disk path required!"
		echo "Usage: ventoy /dev/sdX (entire disk not a partition)"
		return 1
	fi

	if [[ ! -b "$1" ]]; then
		echo "$1 is not a block device"
		return 1
	fi

	sudo /home/h0nzra/Applications/Ventoy/Ventoy2Disk.sh "$1"
}
