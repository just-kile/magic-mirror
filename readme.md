# Magic Mirror

## Architecture

![Architecture Diagram](/doc/architecture.png)

## Run

* SSh to PI
* Start vnc server `vncserver`
* Switch to Python env `workon cv`

## Switch Display
```sh
export DISPLAY=:0
xrandr -o left
```

```sh
chromium-browser http://localhost:3000 --auto-open-devtools-for-tabs
```

-start-fullscreen