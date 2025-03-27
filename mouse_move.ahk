global mouseMode := true
global speed := 2.0
global moveX := 0
global moveY := 0

; move for every 10ms
SetTimer MoveMouse, 10

; use hjkl to move left, down, up, right
#HotIf mouseMode
h:: {
    global moveX
    moveX := -10
}
h up:: {
    global moveX
    if (moveX < 0)
        moveX := 0
}

l:: {
    global moveX
    moveX := 10
}
l up:: {
    global moveX
    if (moveX > 0)
        moveX := 0
}

k:: {
    global moveY
    moveY := -10
}
k up:: {
    global moveY
    if (moveY < 0)
        moveY := 0
}

j:: {
    global moveY
    moveY := 10
}
j up:: {
    global moveY
    if (moveY > 0)
        moveY := 0
}

; speed management
; fast, dash, slow, and amble
f:: {
    global speed
    speed := 8.0
}
f up:: {
    global speed
    speed := 2.0
}

d:: {
    global speed
    speed := 4.0
}
d up:: {
    global speed
    speed := 2.0
}

s:: {
    global speed
    speed := 1.0
}
s up:: {
    global speed
    speed := 2.0
}

a:: {
    global speed
    speed := 0.5
}
a up:: {
    global speed
    speed := 2.0
}

; mouse clicks
; left click
space:: {
    Click "Down"
}
space up:: {
    Click "Up"
}

; right click
::: {
    Click 'R'
}

; wheel up and down
u:: {
    Click 'WheelUp'
}
i:: {
    Click 'WheelDown'
}

#HotIf
^+[:: {
    global mouseMode
    mouseMode := !mouseMode 
}

MoveMouse() {
    global moveX, moveY, mouseMode, speed
    if ((moveX or moveY) and mouseMode) {
        MouseMove(moveX * speed, moveY * speed, 0, "R")
    }
}
