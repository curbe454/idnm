originalSpeed := 2.0

global MouseMode := {
    isOn: true,
    speed: 2.0,
    moveX: 0,
    moveY: 0,
    speedStack: [originalSpeed,]
}

PushSpeed(newSpeed) {
    global MouseMode
    MouseMode.speedStack.Push(newSpeed)
    MouseMode.speed := newSpeed
}

PopSpeed() {
    global MouseMode
    MouseMode.speedStack.Pop()

    ; bug happens when I use bluetooth keyboard. reset speed stack for unstable IO.
    MouseMode.speedStack := [
        MouseMode.speedStack.Length > 0 ? MouseMode.speedStack[1] : MouseMode.speed,
    ]

    MouseMode.speed := MouseMode.speedStack[-1] ; the first speed must be originalSpeed
}

ArrToStr1d(arr) {
    str := ""
    for _,v in arr
        str .= v ","
    return str
}

; mode switch
^+[:: {
    global MouseMode
    MouseMode.isOn := !MouseMode.isOn
    ToolTip (MouseMode.isOn ? "On" : "Off"), 0, 0
    SetTimer () => ToolTip(), -1500
}

; move for every 10ms
SetTimer MoveMouse, 10
MoveMouse() {
    global MouseMode
    if ((MouseMode.moveX or MouseMode.moveY) and MouseMode.isOn) {
        MouseMove(MouseMode.moveX * MouseMode.speed, MouseMode.moveY * MouseMode.speed, 0, "Relative")
    }
}

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
f::PushSpeed(8.0)
d::PushSpeed(4.0)
s::PushSpeed(1.0)
a::PushSpeed(0.5)

f up::PopSpeed()
d up::PopSpeed()
s up::PopSpeed()
a up::PopSpeed()

; change original speed
q::MouseMode.SpeedStack[1] := MouseMode.SpeedStack[1] + 1.0
w::MouseMode.SpeedStack[1] := MouseMode.SpeedStack[1] - 1.0

; mouse clicks
; left click
c::Click("Down")
c up::Click("Up")

; right click
:::Click("Right")

; wheel up and down
u::Click("WheelUp")
i::Click("WheelDown")

; print messages for debug
p:: {
    global MouseMode
    speedStr := "SpeedStack: [" ArrToStr1d(MouseMode.SpeedStack) "]"
    ToolTip speedStr , 0, 0
    SetTimer () => ToolTip(), -1500
}

#HotIf

