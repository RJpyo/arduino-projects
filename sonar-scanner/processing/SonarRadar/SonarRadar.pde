import processing.serial.*;

final int SERIAL_PORT_INDEX = 0;
final int BAUD_RATE = 9600;
final int MAX_DISTANCE_CM = 40;

Serial arduinoPort;
int angle = 0;
int distance = 0;

void setup() {
  size(1000, 650);
  smooth();
  textFont(createFont("Arial", 16));

  println("Available serial ports:");
  printArray(Serial.list());

  if (Serial.list().length == 0) {
    println("No serial ports found. Connect the Arduino and restart the sketch.");
    return;
  }

  if (SERIAL_PORT_INDEX < 0 || SERIAL_PORT_INDEX >= Serial.list().length) {
    println("SERIAL_PORT_INDEX is invalid. Choose an index from the list above.");
    return;
  }

  arduinoPort = new Serial(this, Serial.list()[SERIAL_PORT_INDEX], BAUD_RATE);
  arduinoPort.clear();
  arduinoPort.bufferUntil('.');
}

void draw() {
  background(0);
  drawRadar();
  drawSweep();
  drawObject();
  drawReadout();
}

void serialEvent(Serial port) {
  String message = port.readStringUntil('.');
  if (message == null) return;

  message = trim(message.substring(0, message.length() - 1));
  String[] fields = split(message, ',');
  if (fields.length != 2) return;

  int receivedAngle = int(trim(fields[0]));
  int receivedDistance = int(trim(fields[1]));

  if (receivedAngle >= 0 && receivedAngle <= 180 && receivedDistance >= 0) {
    angle = receivedAngle;
    distance = receivedDistance;
  }
}

void drawRadar() {
  pushMatrix();
  translate(width / 2, height - 90);
  noFill();
  stroke(0, 220, 0);
  strokeWeight(2);

  float radius = min(width - 80, (height - 130) * 2);
  for (int ring = 1; ring <= 4; ring++) {
    arc(0, 0, radius * ring / 4.0, radius * ring / 4.0, PI, TWO_PI);
  }

  for (int deg = 0; deg <= 180; deg += 30) {
    float x = cos(radians(deg)) * radius / 2;
    float y = -sin(radians(deg)) * radius / 2;
    line(0, 0, x, y);
  }
  popMatrix();

  fill(70, 200, 255);
  noStroke();
  textAlign(CENTER);
  for (int cm = 10; cm <= MAX_DISTANCE_CM; cm += 10) {
    float x = map(cm, 0, MAX_DISTANCE_CM, width / 2, width - 40);
    text(cm + " cm", x, height - 70);
  }
}

void drawSweep() {
  pushMatrix();
  translate(width / 2, height - 90);
  stroke(0, 255, 80);
  strokeWeight(3);
  float radius = min(width - 80, (height - 130) * 2) / 2;
  line(0, 0, cos(radians(angle)) * radius, -sin(radians(angle)) * radius);
  popMatrix();
}

void drawObject() {
  if (distance <= 0 || distance > MAX_DISTANCE_CM) return;

  pushMatrix();
  translate(width / 2, height - 90);
  float radius = min(width - 80, (height - 130) * 2) / 2;
  float start = map(distance, 0, MAX_DISTANCE_CM, 0, radius);
  float x1 = cos(radians(angle)) * start;
  float y1 = -sin(radians(angle)) * start;
  float x2 = cos(radians(angle)) * radius;
  float y2 = -sin(radians(angle)) * radius;
  stroke(255, 30, 30);
  strokeWeight(8);
  line(x1, y1, x2, y2);
  popMatrix();
}

void drawReadout() {
  fill(70, 200, 255);
  noStroke();
  textAlign(LEFT);
  text("Angle: " + angle + "°", 18, height - 25);
  text("Distance: " + distance + " cm", 245, height - 25);
}
