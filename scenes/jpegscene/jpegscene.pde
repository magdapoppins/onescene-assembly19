PFont sourceLight;
PImage img;

void setup() {
  size(1800, 1000);
  sourceLight = createFont("Yu Gothic UI Semilight", 40);
  textFont(sourceLight);
}

int counter = 0;
String[] prelude = {
  "Shall I compare thee to a summer’s day?",
  "Thou art more lovely and more temperate:",
  "Rough winds do shake the darling buds of May,",
  "And summer’s lease hath all too short a date;" };

void draw (){
  tint(100);
  img = loadImage("asd.jpg");
  image(img, -800, -800);
  fill(0, 0, 0, 120);
  text(prelude[counter], 600, 300);
}

void keyPressed() {
  if (key == CODED && keyCode == UP) {
    counter += 1;
  }
}
