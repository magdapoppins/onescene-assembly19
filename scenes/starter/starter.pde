import moonlander.library.*;
import ddf.minim.*;

float now = 0.0;

float CANVAS_WIDTH = 1920;
float CANVAS_HEIGHT = 1080;
float BRICK_WIDTH = CANVAS_WIDTH/60;
float BRICK_HEIGHT = CANVAS_HEIGHT/60;

Moonlander moonlander;
PFont font;
PImage lake;
PShape rev2;
PShape rev1;

String[] prelude = {
  "shall I compare ",
  "thee",
  "summer’s lease hath",
  "all too short" 
};

void settings () {
  // Set to false when in dev mode
  boolean inDev = true;
  
  if (!inDev) {
    fullScreen(P3D);
  } else {
    size((int)CANVAS_WIDTH,(int)CANVAS_HEIGHT, P3D);
  }
}

void setup () {
  // set correct font
  font = createFont("Monospaced.plain", 70);
  textFont(font);
  
  frameRate(60);
  lake = loadImage("asd.jpg");
  //rev1 = loadShape("revolver.stl");
  //rev2 = loadShape("revolver_body.stl");  
          
  int bpm = 80;
  int rowsPerBeat = 4; 
  
  moonlander = Moonlander.initWithSoundtrack(this, "Division.mp3", bpm, rowsPerBeat);
  moonlander.start();
}

void snowStorm() {
  for (float x = 0; x < CANVAS_WIDTH; x+=CANVAS_WIDTH/60) {
    for (float y = 0; y < CANVAS_HEIGHT; y+=CANVAS_HEIGHT/60) {
      noStroke();
      fill(random(255));
      rect(x, y, CANVAS_WIDTH/60, CANVAS_HEIGHT/60);
    }
  }
}

void rainbowStorm() {
  for (float x = 0; x < CANVAS_WIDTH; x+=CANVAS_WIDTH/60) {
    for (float y = 0; y < CANVAS_HEIGHT; y+=CANVAS_HEIGHT/60) {
      noStroke();
      fill(x*0.3, y*0.2, random(255));
      rect(x, y, CANVAS_WIDTH/60, CANVAS_HEIGHT/60);
    }
  }
}

void endStorm() {
  
  for (float x = 0; x < CANVAS_WIDTH; x+=CANVAS_WIDTH/60) {
    for (float y = 0; y < CANVAS_HEIGHT; y+=CANVAS_HEIGHT/60) {
      float emptyOne = random(100);
      if (emptyOne < 10) {
        noStroke();
        fill(0);
        rect(x, y, CANVAS_WIDTH/60, CANVAS_HEIGHT/60);
      }
    }
  }
}

void zipOff(float step) {
  background(0);
  rect(0, step * (CANVAS_HEIGHT/8), CANVAS_WIDTH, CANVAS_HEIGHT - ((step / 4) * CANVAS_HEIGHT));
  println("HEIGHT", CANVAS_HEIGHT - ((step / 4) * CANVAS_HEIGHT + 60.5));
}

void drawSun(boolean blinkOff) {
  float sunCenterPointX = CANVAS_WIDTH/2 + 0.5 * BRICK_WIDTH;
  float sunCenterPointY = CANVAS_HEIGHT/2;
  
  noStroke();
  fill(100, 100, 0);
  // Top (2 bricks wide)
  rect(CANVAS_WIDTH/2, CANVAS_HEIGHT/2 + 2 * BRICK_HEIGHT, 2 * BRICK_WIDTH, BRICK_HEIGHT);
  // Center (4 bricks wide)
  rect(CANVAS_WIDTH/2 - BRICK_WIDTH, CANVAS_HEIGHT/2 + BRICK_HEIGHT, 4 * BRICK_WIDTH, BRICK_HEIGHT);
  rect(CANVAS_WIDTH/2 - BRICK_WIDTH, CANVAS_HEIGHT/2, 4 * BRICK_WIDTH, BRICK_HEIGHT);
  rect(CANVAS_WIDTH/2 - BRICK_WIDTH, CANVAS_HEIGHT/2 - BRICK_HEIGHT, 4 * BRICK_WIDTH, BRICK_HEIGHT);
  rect(CANVAS_WIDTH/2 - BRICK_WIDTH, CANVAS_HEIGHT/2 - 2 * BRICK_HEIGHT, 4 * BRICK_WIDTH, BRICK_HEIGHT);
  // Bottom (2 bricks wide)
  rect(CANVAS_WIDTH/2, CANVAS_HEIGHT/2 - (3 * BRICK_HEIGHT), 2 * BRICK_WIDTH, BRICK_HEIGHT);
  if (!blinkOff) {
    for (int i = 0; i < 10; i++) {
      float y = sunCenterPointY + 120 * sin(i * 2 * PI / 10.0);
      float x = sunCenterPointX + 120 * cos(i * 2 * PI / 10.0);      
      rect(
        x,
        y,
        BRICK_HEIGHT, 
        BRICK_HEIGHT);
    }
  }
}

void glitches() {
  for (int i = 0; i < 20; i++) {
    drawImage(counter * 20);
  }
}

void drawImage(int positionX) {
  filter(INVERT);
  image(lake, positionX, -800);
}

void drawBox(float x, float y, float z) {
  pushMatrix();
  noStroke();
  translate(x, y, z);
  rotateY(PI/5);
  box(BRICK_WIDTH, BRICK_HEIGHT, 50);
  popMatrix();
}

int counter = 0;
boolean flickerOff;

void draw () {
  
  moonlander.update();

  now = (float)moonlander.getCurrentTime();
  
  float end = 30.0;
  if (now > end) {
    exit();
  }

  if (now < 1) {
    fill(255, 0, 255);
    background(0);
    text(prelude[0], CANVAS_WIDTH/2 - 530, CANVAS_HEIGHT/2);
  } else if (now < 2) {
    text(prelude[1], CANVAS_WIDTH/2 + 130, CANVAS_HEIGHT/2);
  } else if (now < 3) {
    flickerOff = random(10) < 7 ? true : false;
    if (flickerOff) { 
      background(0);
    } else {
      text(prelude[1], CANVAS_WIDTH/2 + 130, CANVAS_HEIGHT/2);
    } 
  } else if (now < 7) {
    flickerOff = random(10) < 3 ? true : false;
    if (flickerOff) { 
      background(0);
    } else {
      fill(0);
      zipOff(now - 3);
    } 
  } else if (now < 10) {
    background(0);
    text(prelude[3], CANVAS_WIDTH/2 - 130, CANVAS_HEIGHT/2 - 200);
    drawSun((int)now % 2 == 0);
    println((int)now % 2 == 0);
  } else if (now < 14) {
    
  } else if (now < 16) {
    background(0);
    if (now < 18) { 
      snowStorm(); 
    } else { 
      text(prelude[0], 300, 300);
      rainbowStorm(); 
    }
  } else if (now < 18) {
    endStorm();
  } else if (now < 25) {
    directionalLight(126, 126, 126, 0, 0, -1);
    ambientLight(102, 102, 102);
    background(0);
    
    drawBox(random(CANVAS_WIDTH), random(CANVAS_HEIGHT), 0);
    drawBox(random(CANVAS_WIDTH), random(CANVAS_HEIGHT), 0);
    drawBox(random(CANVAS_WIDTH), random(CANVAS_HEIGHT), 0);
    drawBox(random(CANVAS_WIDTH), random(CANVAS_HEIGHT), 0);
    
    counter++; 
  } else if (now < 40) {
    background(0);
    
    text(prelude[2], 700, 800);
    text(prelude[3], 900, 900); 
     
    for (int i = 0; i < 200; i++) {
     drawBox(CANVAS_WIDTH/2, CANVAS_HEIGHT/2, i);    
    }
  } else if (now < 45) {
    
    for (int i = 0; i < 100; i++) {
      drawImage(i + 50);      
    }
    
    for (int i = 0; i < 100; i++) {
      drawImage(i * 10);      
    }
  }
}
