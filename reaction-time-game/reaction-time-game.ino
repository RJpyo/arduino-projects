int whiteLED1 = 12;
int whiteLED2 = 8;
int greenLED = 11;
int yellowLED = 10;
int redLED = 9;

int buzzer = 7;
int button1 = 13;
int button2 = 6;

bool buttonPressed = false;

void setup() {
  pinMode(whiteLED1, OUTPUT);
  pinMode(whiteLED2, OUTPUT);
  pinMode(greenLED, OUTPUT);
  pinMode(yellowLED, OUTPUT);
  pinMode(redLED, OUTPUT);
  pinMode(buzzer, OUTPUT);
  pinMode(button1, INPUT_PULLUP);
  pinMode(button2, INPUT_PULLUP);
}

void loop() {
  digitalWrite(greenLED, HIGH);
  delay(1000);
  digitalWrite(greenLED, LOW);

  digitalWrite(yellowLED, HIGH);
  delay(1000);
  digitalWrite(yellowLED, LOW);

  digitalWrite(redLED, HIGH);
  delay(1000);
  digitalWrite(redLED, LOW);

  while (!buttonPressed) {
    digitalWrite(whiteLED1, HIGH);
    digitalWrite(whiteLED2, HIGH);
    if (digitalRead(button1) == LOW) {
      buttonPressed = true;
      digitalWrite(whiteLED2, LOW);
    } else if (digitalRead(button2) == LOW) {
      buttonPressed = true;
      digitalWrite(whiteLED1, LOW);
    }
  }

  delay(2000);
  digitalWrite(whiteLED1, LOW);
  digitalWrite(whiteLED2, LOW);
  buttonPressed = false;
}
