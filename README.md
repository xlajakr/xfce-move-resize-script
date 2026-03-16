# XFCE Move and Resize Script

This script fixes the problem of changing the step size of resizing/moving windows with the keyboard.  
Works on my machine; no idea if it will work on yours.  
Please excuse the horrible code I quickly produced. Thanks.

## Usage

```bash
script.sh [argument] [side] [step size]
```

### argument
- `move` — moves the currently focused window to `[side]` by `[step size]` pixels.  
- `resize` — increments or decrements the currently focused window by `[step size]` pixels.

### side
- If `argument = move`:
    - `side` = `left` / `right` / `top` / `down`  
- If `argument = resize`:
    - `side` = `inc` / `dec`

### Example Usage (bind to some keybind in settings)
```bash
./script.sh move left 100   # moves the window to the left by 100px
./script.sh resize inc 100  # increments the width and height of the window by 100px
```
