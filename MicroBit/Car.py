def Create_barrier():
    for index in Barriers[randint(0, len(Barriers) - 1)]:
        Bar.unshift(index)
        Plot(index)

def on_button_pressed_a():
    Change_position(-10)
input.on_button_pressed(Button.A, on_button_pressed_a)

def Unplot(cell: number):
    led.unplot(cell / 10, cell % 10)

def on_button_pressed_b():
    Change_position(10)
input.on_button_pressed(Button.B, on_button_pressed_b)

def Change_position(dir: number):
    global NewPos, Position
    if Pause == True:
        control.reset()
    NewPos = Position + dir
    if NewPos >= 4 and (NewPos <= 44 and Bar.index(NewPos) == -1):
        Unplot(Position)
        Position = NewPos
        Plot(Position)
def Plot(cell: number):
    led.plot(cell / 10, cell % 10)
b = 0
Delete: List[number] = []
NewPos = 0
Bar: List[number] = []
Barriers: List[List[number]] = []
Pause = False
Position = 0
basic.show_leds("""
    # # # # #
    # # # # #
    # # # # #
    # # # # #
    # # # # #
    """)
basic.pause(200)
basic.show_leds("""
    . . . . .
    . . . . .
    . . . . .
    . . . . .
    . . . . .
    """)
Delay = 1000
Position = 24
Plot(Position)
Pause = False
Counter = 2
Score = -2
Barriers = [[10, 20, 30, 40],
    [0, 20, 30, 40],
    [0, 10, 30, 40],
    [0, 10, 20, 40],
    [0, 10, 20, 30],
    [20, 30, 40],
    [0, 30, 40],
    [0, 10, 40],
    [0, 10, 20],
    [10, 20, 30],
    [0, 20, 40],
    [10, 20, 40],
    [10, 30, 40],
    [0, 20, 30],
    [0, 10, 30]]

def on_forever():
    global Counter, Score, Delay, Delete, b, Pause
    if Pause == False:
        if Counter == 2:
            Create_barrier()
            Counter = 0
            Score += 1
        Counter += 1
        basic.pause(Delay)
        Delay = max(400, Delay - 6)
        Delete = []
        index2 = 0
        while index2 <= len(Bar) - 1:
            b = Bar[index2]
            Unplot(b)
            b += 1
            if b == Position:
                Pause = True
                break
            Bar[index2] = b
            Plot(b)
            if b % 10 >= 5:
                Delete.unshift(index2)
            index2 += 1
        for index3 in Delete:
            Bar.remove_at(index3)
    else:
        basic.show_number(Score)
basic.forever(on_forever)
