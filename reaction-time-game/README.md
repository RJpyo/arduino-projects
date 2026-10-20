# Reaction Time Game

A two-player Arduino game: wait for the coloured light sequence to finish, then press your button first. The winner's white LED stays on for two seconds before the next round.

## Parts

- Arduino Uno or compatible board
- Breadboard and jumper wires
- Two white LEDs, one green, one yellow, and one red LED
- One series resistor per LED (typically 220–330 ohms for a 5 V Uno)
- Two momentary push buttons
- USB cable
- Optional buzzer: pin 7 is configured but unused

## Wiring

Disconnect power before changing wiring. Connect Arduino GND to the breadboard ground rail.

| Component | Arduino pin | Connection |
| --- | --- | --- |
| Player 1 white LED | 12 | Pin → resistor → LED anode; cathode → GND |
| Player 2 white LED | 8 | Pin → resistor → LED anode; cathode → GND |
| Green LED | 11 | Pin → resistor → LED anode; cathode → GND |
| Yellow LED | 10 | Pin → resistor → LED anode; cathode → GND |
| Red LED | 9 | Pin → resistor → LED anode; cathode → GND |
| Player 1 button | 13 | Connects pin to GND only while pressed |
| Player 2 button | 6 | Connects pin to GND only while pressed |

The LED anode is usually the longer leg. The cathode is usually the shorter leg, beside the flat edge of the casing.

Buttons use `INPUT_PULLUP`: released reads HIGH and pressed reads LOW. No external pull-down resistor is needed. Four-legged buttons contain internally connected pairs; choose contacts that connect only when pressed. Many fit across the breadboard centre gap. Bridge any split ground rail sections you use.

## Run the game

1. Open `reaction-time-game.ino` in the Arduino IDE.
2. Select your board and port, then upload.
3. Green, yellow, and red light up for one second each.
4. When both white LEDs turn on, press your button.
5. The winning player's white LED stays lit for two seconds, then the next round starts.

## What I learned

A white LED seemed broken, but a simple output test showed it worked. Both white LEDs stayed on with the button wires disconnected. The button wiring was causing an input to read as continuously pressed. Fixing the connections solved the issue.

## Current behaviour

- Holding a button before the white lights appear counts immediately.
- If both inputs are LOW when checked, player 1 wins because it is checked first.
- The game shows a winner; it does not measure reaction time numerically.
- The buzzer is configured but unused.

## Tutorial reference

Built while following a [Robonyx classroom lesson](https://www.skool.com/robonyx/classroom/de13e21c?md=161261021dbe44c4831718968e1f5147). The sketch is based on the code shared during this build. No course video or course files are included. No licence is asserted for tutorial-derived code; check the creator's terms before redistributing it publicly.
