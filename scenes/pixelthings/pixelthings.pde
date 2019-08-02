PImage lake;
PImage stars;

void setup () {
  size(3300, 3300);
  lake = loadImage("asd.jpg");
  stars = loadImage("stars.jpg");
  frameRate(1);
}

void draw () {
  //background(stars);
  //tint(255, 230); 
  //image(lake, -900, -900);
  // Before we deal with pixels
  loadPixels();  
  // Loop through every pixel
  for (int i = 0; i < pixels.length; i++) {
    // Pick a random number, 0 to 255
    float rand = random(255);
    // Create a grayscale color based on random number
    color c = color(rand);
    // Set pixel at that location to random color
    pixels[i] = c;
  }
  // When we are finished dealing with pixels
  updatePixels(); 
}
