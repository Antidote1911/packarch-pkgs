#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query | grep " connected" | cut -d" " -f1 | wc -l)


case $desktop in

    openbox|/usr/share/xsessions/openbox)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload top -c ~/.config/polybar/config_ob.ini &
      done
    else
    polybar --reload top -c ~/.config/polybar/config_ob.ini &
    fi
    # second polybar at bottom
    if type "xrandr" > /dev/null; then
       for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
         MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config_ob.ini &
       done
     else
     polybar --reload bottom -c ~/.config/polybar/config_ob.ini &
     fi
    ;;

    bspwm|/usr/share/xsessions/bspwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload top -c ~/.config/polybar/config_bspwm.ini &
      done
    else
    polybar --reload top -c ~/.config/polybar/config_bspwm.ini &
    fi
    # second polybar at bottom
     if type "xrandr" > /dev/null; then
       for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
         MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config_bspwm.ini &
       done
     else
     polybar --reload bottom -c ~/.config/polybar/config_bspwm.ini &
     fi
    ;;

    herbstluftwm|/usr/share/xsessions/herbstluftwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload top -c ~/.config/polybar/config_hlwm.ini &
      done
    else
    polybar --reload top -c ~/.config/polybar/config_hlwm.ini &
    fi
    # second polybar at bottom
     if type "xrandr" > /dev/null; then
       for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
         MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config_hlwm.ini &
       done
     else
     polybar --reload bottom -c ~/.config/polybar/config_hlwm.ini &
     fi
    ;;

    xmonad|/usr/share/xsessions/xmonad)
    if [ $count = 1 ]; then
      m=$(xrandr --query | grep " connected" | cut -d" " -f1)
      MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
    else
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
      done
    fi
    # second polybar at bottom
    # if [ $count = 1 ]; then
    #   m=$(xrandr --query | grep " connected" | cut -d" " -f1)
    #   MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    # else
    #   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #     MONITOR=$m polybar --reload mainbar-xmonad-extra -c ~/.config/polybar/config &
    #   done
    # fi
    ;;

    spectrwm|/usr/share/xsessions/spectrwm)
    if type "xrandr" > /dev/null; then
      for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
        MONITOR=$m polybar --reload mainbar-spectrwm -c ~/.config/polybar/config &
      done
    else
    polybar --reload mainbar-spectrwm -c ~/.config/polybar/config &
    fi
    ;;

esac
