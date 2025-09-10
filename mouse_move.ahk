global MouseMode := {
    isOn: true,
    speed: 2.0,
    moveX: 0,
    moveY: 0,
}

; move for every 10ms
SetTimer MoveMouse, 10

; use hjkl to move left, down, up, right
#HotIf MouseMode.isOn

h::MouseMode.moveX := -10
l::MouseMode.moveX := 10
k::MouseMode.moveY := -10
j::MouseMode.moveY := 10

h up:: {
    global MouseMode
    if (MouseMode.moveX < 0)
        MouseMode.moveX := 0
}
l up:: {
    global MouseMode
    if (MouseMode.moveX > 0)
        MouseMode.moveX := 0
}
k up:: {
    global MouseMode
    if (MouseMode.moveY < 0)
        MouseMode.moveY := 0
}
j up:: {
    global MouseMode
    if (MouseMode.moveY > 0)
        MouseMode.moveY := 0
}

; mouse speed management
; fast, dash, slow, and amble
f::MouseMode.speed := 8.0
d::MouseMode.speed := 4.0
s::MouseMode.speed := 1.0
a::MouseMode.speed := 0.5

f up::MouseMode.speed := 2.0
d up::MouseMode.speed := 2.0
s up::MouseMode.speed := 2.0
a up::MouseMode.speed := 2.0

; mouse clicks
; left click
c:: {
    Click "Down"
}
c up:: {
    Click "Up"
}

; right click
::: {
    Click "Right"
}

; wheel up and down
u:: {
    Click "WheelUp"
}
i:: {
    Click "WheelDown"
}

#HotIf

^+[:: {
    global MouseMode
    MouseMode.isOn := !MouseMode.isOn
    ToolTip (MouseMode.isOn ? "On" : "Off"), 0, 0
    SetTimer () => ToolTip(), -1500
}

MoveMouse() {
    global MouseMode
    if ((MouseMode.moveX or MouseMode.moveY) and MouseMode.isOn) {
        MouseMove(MouseMode.moveX * MouseMode.speed, MouseMode.moveY * MouseMode.speed, 0, "Relative")
    }
}
