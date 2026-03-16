# xfce move and resize script

This script fixes the problem of changing the step size of resizing/moving windows with keyboard.
Works on my machine. No idea if it will work on your.
Please do excuse the horrible code i quickly produced. Thanks

  ##Usage
`script.sh [argument] [side] [step size]`
    ###argument 
    move ( moves the current focused window to [side] by [step size] pixels
    resize ( increments or decrements the current focused window by [step size] pixels
    ###side
      if argument = move:
        side = (left/right/top/down)
      else if argument = resize:
        side = (inc/dec) 
    ###example usage (bind to some keybind in settings)
    `./script.sh move left 100` moves the window to the left by 100px
    `./script.sh resize inc 100` increments the width and height of the window by 100px
