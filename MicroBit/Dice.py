def Random():
    return randint(1, 6)

def on_button_pressed_a():
    global number, double
    number = Random()
    double = 0
    basic.show_leds("""
        # # # # #
                # # # # #
                # # # # #
                # # # # #
                # # # # #
    """)
    basic.pause(100)
    basic.show_number(number)
input.on_button_pressed(Button.A, on_button_pressed_a)

def on_button_pressed_b():
    global number, number2, double
    number = Random()
    number2 = Random()
    double = 0
    basic.show_leds("""
        # # # # #
                # # # # #
                # # # # #
                # # # # #
                # # # # #
    """)
    basic.pause(100)
    if number == number2:
        double = 1
    if number + number2 == 10:
        basic.show_string("A")
    elif number + number2 == 11:
        basic.show_string("B")
    elif number + number2 == 12:
        basic.show_string("C")
    else:
        basic.show_number(number + number2)
input.on_button_pressed(Button.B, on_button_pressed_b)

number2 = 0
double = 0
number = 0
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

def on_forever():
    if double == 1:
        led.toggle(4, 0)
        basic.pause(200)
basic.forever(on_forever)
