#!/bin/sh


# get active window id
arg=$1
side=$2
step_size=$3

wid=$(xprop -root _NET_ACTIVE_WINDOW)
set -- $wid
wid=$(echo $5 | sed 's/,//g')
echo $wid

coords=$(xwininfo -id "$wid" | grep -E "Absolute upper-left X:| Absolute upper-left Y: |Width:|Height:")
coords_relative=$(xwininfo -id "$wid" | grep -E "Relative upper-left X:| Relative upper-left Y: |Width:|Height:")
coords2=$(xwininfo -id "$wid" | grep -E "Width:|Height:")

set -- $coords
win_x=$4
win_y=$8
set -- $coords2
win_width=$2
win_height=$4
set -- $coords_relative
win_x=$(($win_x - $4))
win_y=$(($win_y - $8))

#bound checking
min_x=0
max_x=1920

min_y=0
max_y=1920

min_height=300
max_height=1100

min_width=300
max_width=1920
# check if the window is out of bounds
if [ "$arg" = "move" ]; then
    case "$side" in
        left)
            if [ "$win_x" -le "$min_x" ]; then
                echo "Cannot move left, at min X"
                exit 0
            fi
            ;;
        right)
            if [ "$((win_x + win_width))" -ge "$max_x" ]; then
                echo "Cannot move right, at max X"
                exit 0
            fi
            ;;
        top)
            if [ "$win_y" -le "$min_y" ]; then
                echo "Cannot move up, at min Y"
                exit 0
            fi
            ;;
        down)
            if [ "$((win_y + win_height))" -ge "$max_y" ]; then
                echo "Cannot move down, at max Y"
                exit 0
            fi
            ;;
    esac
    
elif [ "$arg" = "resize" ]; then
    # resize bounds check
    case "$side" in
    dec)
        if [ "$win_width" -lt "$min_width" ] || [ "$win_height" -lt "$min_height" ]; then
            exit 0
        fi
        ;;
    dec)
        if [ "$win_height" -lt "$min_height" ] || [ "$win_width" -gt "$max_width" ]; then
            exit 0
        fi
        ;;
    esac
fi
if [ "$arg" = "move" ]; then

    if [ "$side" = "left" ]; then
        win_x=$(($win_x - $step_size))
    elif [ "$side" = "right" ]; then
        win_x=$(($win_x + $step_size))
    elif [ "$side" = "top" ]; then
        win_y=$(($win_y - $step_size))
    elif [ "$side" = "down" ]; then
        win_y=$(($win_y + $step_size))
    fi

elif [ "$arg" = "resize" ]; then
    if [ "$side" = "inc" ]; then
        win_width=$(($win_width+ $step_size))
        win_height=$(($win_height + $step_size))
    elif [ "$side" = "dec" ]; then
        win_width=$(($win_width - $step_size))
        win_height=$(($win_height - $step_size))
    fi

fi

wmctrl -i -r "$wid" -e 0,$win_x,$win_y,$win_width,$win_height
