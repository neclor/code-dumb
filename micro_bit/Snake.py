def on_button_pressed_a():
    global Direction2
    Direction2 = Lefts[Direction2]
input.on_button_pressed(Button.A, on_button_pressed_a)

def Unplot(cell: number):
    led.unplot(cell / 10, cell % 10)
def Add_Rabit():
    global RabCoord
    while True:
        RabCoord = randint(0, 4) * 10 + randint(0, 4)
        if Snake.index(RabCoord) < 0:
            break

def on_button_pressed_b():
    global Direction2
    Direction2 = Rights[Direction2]
input.on_button_pressed(Button.B, on_button_pressed_b)

def Plot(cell: number):
    led.plot(cell / 10, cell % 10)
Next = 0
RabCoord = 0
Snake: List[number] = []
Direction2 = 0
Lefts: List[number] = []
Rights: List[number] = []
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
Add_Rabit()
Rights = [2, 2, 3, 4, 1]
Lefts = [4, 4, 1, 2, 3]
Moves = [0, -1, 10, 1, -10]
Direction2 = 1
Snake = [23]
Fields = [0,
    1,
    2,
    3,
    4,
    10,
    11,
    12,
    13,
    14,
    20,
    21,
    22,
    23,
    24,
    30,
    31,
    32,
    33,
    34,
    40,
    41,
    42,
    43,
    44]

def on_forever():
    global Next
    Next = Snake[0] + Moves[Direction2]
    if Fields.index(Next) < 0 or Snake.index(Next) >= 0:
        control.reset()
    if Next == RabCoord:
        Plot(Next)
        Add_Rabit()
    else:
        Plot(Next)
        Unplot(Snake.pop())
    Snake.unshift(Next)
    if len(Snake) == 25:
        basic.show_string("You WIN!")
        control.reset()
    basic.pause(1000)
basic.forever(on_forever)

def on_forever2():
    Plot(RabCoord)
    basic.pause(100)
    Unplot(RabCoord)
    basic.pause(100)
basic.forever(on_forever2)
