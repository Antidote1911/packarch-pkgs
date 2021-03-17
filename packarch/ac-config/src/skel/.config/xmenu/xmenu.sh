#!/bin/bash

### PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

WM="$DESKTOP_SESSION"
LOGOUT=""
RESTARTWM=""

if [[ $WM == "bspwm" ]]; then
	LOGOUT="bspc quit"
	RESTARTWM="bspc wm -r"
  	
  	elif [[ $WM == "herbstluftwm" ]]; then
  	LOGOUT="herbstclient quit"
  	RESTARTWM="herbstclient reload"
  	
  	elif [[ $WM == "openbox" ]]; then
  	LOGOUT="openbox --exit"
  	RESTARTWM="openbox --restart"
	fi

cat <<EOF | xmenu | sh &
Install Packarch			sudo alacritty -e /installer/install_packarch.sh
Internet						(firefox &> /dev/null &)
File Manager
	Pcmanfm				(pcmanfm &> /dev/null &)
	Ranger					alacritty -e ranger
	Ranger Float				alacritty --class alacritty-float,alacritty-float --config-file $HOME/.config/alacritty/alacritty.yml -e ranger
Terminal
	alacritty					alacritty
	alacritty Float				alacritty --class alacritty-float,alacritty-float --config-file $HOME/.config/alacritty/alacritty.yml
Htop						alacritty -e htop
Pamac Manager					(pamac-manager &> /dev/null &)

Apps as root
	Terminal
		alacritty				sudo alacritty --config-file /root/.config/alacritty/alacritty.yml
		alacritty Float			sudo alacritty --class alacritty-float,alacritty-float --config-file /root/.config/alacritty/alacritty.yml
	File Manager
		Ranger				sudo alacritty --config-file /root/.config/alacritty/alacritty.yml -e ranger
		Ranger Float			sudo alacritty --class alacritty-float,alacritty-float --config-file /root/.config/alacritty/alacritty.yml -e ranger
		Pcmanfm			(sudo pcmanfm &> /dev/null &)
	Leafpad					(sudo leafpad &> /dev/null &)
	Geany					(sudo geany &> /dev/null &)
	Nvim					sudo alacritty -e nvim
Applications
	Multimedia
		SMplayer			(smplayer &> /dev/null &)
		Spotify				(flatpak run com.spotify.Client &> /dev/null &)
		Mp3 Player			alacritty -e ncmpcpp
		Visualizer			alacritty -e cava
	Graphism
		Gimp				(gimp &> /dev/null &)
		Gcolor2				(gcolor2 &> /dev/null &)
		Color Picker			color_picker
	Develop
		Atom				(atom &> /dev/null &)
		QtCreator			(qtcreator &> /dev/null &)
	Utils
		Htop				alacritty -e htop
		Geany				(geany &> /dev/null &)
		Leafpad				(leafpad &> /dev/null &)
		Vmware				(vmware &> /dev/null &)
		KeepassXC			(keepassxc &> /dev/null &)
		Veracrypt			(veracrypt &> /dev/null &)
		Fonts Manager		(font-manager &> /dev/null &)
		Bootable Usb			(mintstick -m iso &> /dev/null &)
		Format Usb			(mintstick -m format &> /dev/null &)
		Infos System			(hardinfo &> /dev/null &)
		Gparted				(gparted &> /dev/null &)
	Funny Apps
		Neofetch			alacritty -e $SHELL -c 'neofetch && $SHELL' &
		Pipes 1				alacritty -e pipes-1.sh
		Pipes 2				alacritty -e pipes-2.sh
		Pipes 3				alacritty -e pipes-3.sh
		Invaders				alacritty -e $SHELL -c 'invaders.sh && $SHELL' &
		Color Bars			alacritty -e $SHELL -c 'colortest.sh && $SHELL' &
		Pacman				alacritty -e $SHELL -c 'pacmancolor.sh && $SHELL' &
		Monsters			alacritty -e $SHELL -c 'monster.sh && $SHELL' &
Configuration
	Edit config files
		Bspwm config		alacritty --class alacritty-float,alacritty-float -e nvim $HOME/.config/bspwm/bspwmrc
		Bspwm sxhkd		alacritty --class alacritty-float,alacritty-float -e nvim $HOME/.config/bspwm/sxhkd/sxhkdrc	
		Edit this menu		alacritty --class alacritty-float,alacritty-float -e nvim $HOME/.config/xmenu/xmenu.sh	
		Restart WM			bspc wm -r
		Reload keybinding	pkill -USR1 -x sxhkd
		Restart Polybar		$HOME/.config/polybar/launch.sh &> /dev/null &
	Change Wallpaper			(nitrogen &> /dev/null &)
	Lxappearance			(lxappearance &> /dev/null &)
	Xfce4 Settings			(xfce4-settings-manager &> /dev/null &)
	Audio Settings			(pavucontrol &> /dev/null &)
Screenshot
	Screenshot Now			shotnow
	Screenshot In 5s			shotin5
	Screenshot In 10s			shotin10
	Screenshot Area			shotArea
	Screenshot Window		shotWindow
Sticky Notes					tasks

Quick Links
	Gmail					(firefox https://mail.google.com &> /dev/null &)
	Facebook				(firefox https://www.facebook.com &> /dev/null &)
	Youtube					(firefox https://www.youtube.com &> /dev/null &)
	Linux
		Archlinux fr			(firefox https://archlinux.fr &> /dev/null &)
		Archlinux			(firefox https://www.archlinux.org &> /dev/null &)
		Distrowatch			(firefox https://distrowatch.com &> /dev/null &)
	Develop
		Github				(firefox https://github.com &> /dev/null &)
		Developpez			(firefox https://www.developpez.com &> /dev/null &)
	Lan
		Syno DS918			(firefox http://192.168.1.96:5000/?_dc=1522237352866 &> /dev/null &)
		Switch				(firefox http://192.168.1.16/login.htm &> /dev/null &)
		Cups				(firefox http://localhost:631/admin &> /dev/null &)
		Livebox				(firefox http://livebox/ &> /dev/null &)
	About Developer			(firefox https://github.com/Antidote1911 &> /dev/null &)
Places
	My Home				(pcmanfm -n $HOME &> /dev/null &)
	Downloads				(pcmanfm -n $(xdg-user-dir DOWNLOAD) &> /dev/null &)
	Videos					(pcmanfm -n $(xdg-user-dir VIDEOS) &> /dev/null &)
	Images					(pcmanfm -n $(xdg-user-dir PICTURES) &> /dev/null &)
	Documents				(pcmanfm -n $(xdg-user-dir DOCUMENTS) &> /dev/null &)
	Config					(pcmanfm -n $HOME/.config &> /dev/null &)
	Syno Ds918
		Syno Partage			(pcmanfm -n /mnt/Partage/ &> /dev/null &)
		Syno Films			(pcmanfm -n /mnt/Partage/Films/ &> /dev/null &)
		Syno Torrents		(pcmanfm -n /mnt/Partage/torrents/ &> /dev/null &)
		Syno Musiques		(pcmanfm -n /mnt/Musiques/ &> /dev/null &)
		Syno Photos			(pcmanfm -n /mnt/Photos/&> /dev/null &)

Lock Screen					betterlockscreen -l blur
Power
	Logout					$LOGOUT
	Reboot					systemctl reboot
	Shutdown				systemctl poweroff
EOF
