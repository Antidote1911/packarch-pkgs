#!/usr/bin/env bash

## This script will download and build AUR pkgs and setup the repository database.

## Dirs
DIR="$(pwd)"
LIST=(picom-jonaburg-git python-pyparted python-clickgen i3lock-color colorpicker snapd snapd-glib pamac-all betterlockscreen fetchmirrors sardi-icons sardi-flat-colora-variations-icons-git networkmanager-dmenu-git perl-linux-desktopfiles polybar yay mintstick-git cava font-manager xtitle-git bibata-cursor-theme)

# Sort packages
PKGS=($(for i in "${LIST[@]}"; do echo $i; done | sort))

## Script Termination
exit_on_signal_SIGINT () {
    { printf "\n\n%s\n" "Script interrupted." 2>&1; echo; }
	if [[ -d $DIR/aur_pkgs ]]; then
		{ rm -rf $DIR/aur_pkgs; exit 0; }
	else
		exit 0
	fi
}

exit_on_signal_SIGTERM () {
    { printf "\n\n%s\n" "Script terminated." 2>&1; echo; }
	if [[ -d $DIR/aur_pkgs ]]; then
		{ rm -rf $DIR/aur_pkgs; exit 0; }
	else
		exit 0
	fi
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Delete previous packages
delete_pkg () {
	if [[ -d $DIR/aur_pkgs ]]; then
		rm -rf $DIR/aur_pkgs
	fi
	{ echo; cd $DIR/x86_64; }
	set -- $DIR/x86_64/${PKGS[0]}-*
	if [[ -f "$1" ]]; then
		for pkg in "${PKGS[@]}"; do
			{ echo "Deleting previous '${pkg}' .pkg file..."; rm -r ${pkg}-*; }
		done
		{ echo "Deleting previous 'plymouth' .pkg file..."; rm -r plymouth-*; }
		{ echo; echo "Done!"; echo; }
	fi
}

# Download AUR packages
download_pkgs () {
	mkdir $DIR/aur_pkgs && cd $DIR/aur_pkgs
	for pkg in "${PKGS[@]}"; do
		git clone --depth 1 https://aur.archlinux.org/${pkg}.git
	# Verify
		while true; do
			set -- $DIR/aur_pkgs/$pkg
			if [[ -d "$1" ]]; then
				{ echo; echo "'${pkg}' downloaded successfully."; }
				break
			else
				{ echo; echo "Failed to download '${pkg}', Exiting..." >&2; }
				{ echo; exit 1; }
			fi
		done
    done
}

# Build AUR packages
build_pkgs () {
	{ echo; echo "Building AUR Packages - "; echo; }
	cd $DIR/aur_pkgs
	for pkg in "${PKGS[@]}"; do
		echo "Building ${pkg}..."
		cd ${pkg} && makepkg -s
		mv *.pkg.tar.zst $DIR/x86_64
		# Verify
		while true; do
			set -- $DIR/x86_64/$pkg-*
			if [[ -f "$1" ]]; then
				{ echo; echo "Package '${pkg}' generated successfully."; echo; }
				break
			else
				{ echo; echo "Failed to build '${pkg}', Exiting..." >&2; }
				{ echo; exit 1; }
			fi
		done
		cd $DIR/aur_pkgs
	done	
}

# Setup repository
setup_repo () {
	repoargs=("-n -R packarch.db.tar.gz *.pkg.tar.zst")
	{ echo "Setting up repository & updating database..."; echo; }
	{ cd $DIR/x86_64; rm -f packarch.*; repo-add $repoargs; }
	{ echo; echo "Database Updated."; echo; }
}

# Cleanup
cleanup () {
	echo "Cleaning up..."
	rm -rf $DIR/aur_pkgs
	if [[ ! -d "$DIR/aur_pkgs" ]]; then
		{ echo; echo "Cleanup Completed."; exit 0; }
	else
		{ echo; echo "Cleanup failed."; exit 1; }
	fi	
}

delete_pkg
download_pkgs
build_pkgs
setup_repo
cleanup
