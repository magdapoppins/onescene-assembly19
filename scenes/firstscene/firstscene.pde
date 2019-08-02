// 0 = none, 255 = full color
int[] hues = {0, 25, 50, 75, 87, 105, 140, 167, 195, 209, 230, 255};
int[] counters = { 0, 5, 2 };
int whichCounterIncrements = 0;
int whichCounterIncrementsModulo = counters.length;
int counterModulo = hues.length;

void setup(){
  size(1200, 360);
}

void draw() {
  if (mousePressed) {
    fill(0);
  } else {
    fill(hues[counters[0]], hues[counters[1]], hues[counters[2]]);
    println(hues[counters[0]], hues[counters[1]], hues[counters[2]]);
    //fill(255, 77, 255);
    
    counters[whichCounterIncrements] += 1;
    counters[whichCounterIncrements] = counters[whichCounterIncrements] % counterModulo;
    
    whichCounterIncrements += 1;
    whichCounterIncrements = whichCounterIncrements % whichCounterIncrementsModulo;
  }
  
  stroke(255);
  ellipse(mouseX, mouseY, 100, 100);
}
