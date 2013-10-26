/*  
 spot_the_difference
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean level1 = true;                                                                             // whether level1 is active or not
boolean level2;                                                                                    // whether level2 is active or not
boolean level3;                                                                                    // whether level3 is active or not
int level1x, level1y, level2x, level2y, level3x, level3y;                                          // row and column coordinates for the different object in each level
int items = 5;                                                                                     // number of rows and columns
int interval;                                                                                      // column width
int shapeDim = 50;                                                                                 // object size

void setup() {
  size(500, 500);
  smooth();
  noStroke();
  interval = width/items;                                                                          // calculate column width
  level1x = floor(random(0, 4.99));                                                                // choose the random column for the different level1 object
  level1y = floor(random(0, 4.99));                                                                // choose the random row for the different level1 object
  level2x = floor(random(0, 4.99));                                                                // choose the random column for the different level2 object
  level2y = floor(random(0, 4.99));                                                                // choose the random row for the different level2 object
  level3x = floor(random(0, 4.99));                                                                // choose the random column for the different level3 object
  level3y = floor(random(0, 4.99));                                                                // choose the random row for the different level3 object
  println("Click on the object that differs from the rest in each level.");
}

void draw() {
  background(255);
  fill(0);
  if (level1) {                                                                                     // if level1 is active
    for (int i = 0; i < items; i++) {
      for (int j = 0; j < items; j++) {
        if (i == level1x && j == level1y) {
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim * 1.1, shapeDim * 1.1);  // draw the different object for level1 (slightly larger size)
        } 
        else {
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim, shapeDim);              // draw the other level1 objects
        }
      }
    }
    if (mousePressed
      && mouseX > ((level1x * 100) + interval/2) - shapeDim/2
      && mouseX < ((level1x * 100) + interval/2) + shapeDim/2
      && mouseY > ((level1y * 100) + interval/2) - shapeDim/2
      && mouseY < ((level1y * 100) + interval/2) + shapeDim/2) {                                    // if the player clicks on the different object
      println("You found it! Level 1 complete.");
      level1 = false;                                                                               // end level 1
      level2 = true;                                                                                // begin level 2
    }
  } 
  else if (level2) {                                                                                // if level2 is active
    for (int i = 0; i < items; i++) {
      for (int j = 0; j < items; j++) {
        if (i == level2x && j == level2y) {
          fill(0, 0, 223);
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim, shapeDim);              // draw the different object for level2 (slightly different fill)
        } 
        else {
          fill(0, 0, 255);
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim, shapeDim);              // draw the other level2 objects
        }
      }
    }
    if (mousePressed
      && mouseX > ((level2x * 100) + interval/2) - shapeDim/2
      && mouseX < ((level2x * 100) + interval/2) + shapeDim/2
      && mouseY > ((level2y * 100) + interval/2) - shapeDim/2
      && mouseY < ((level2y * 100) + interval/2) + shapeDim/2) {                                    // if the player clicks on the different object
      println("You found it! Level 2 complete.");
      level2 = false;                                                                               // end level 2
      level3 = true;                                                                                // begin level 3
    }
  } 
  else if (level3) {                                                                                // if level3 is active
    for (int i = 0; i < items; i++) {
      for (int j = 0; j < items; j++) {
        if (i == level3x && j == level3y) {
          strokeWeight(2);
          stroke(32);
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim, shapeDim);              // draw the different object for level3 (colored stroke)
        } 
        else {
          noStroke();
          ellipse((i * 100) + interval/2, (j * 100) + interval/2, shapeDim, shapeDim);              // draw the other level3 objects
        }
      }
    }
    if (mousePressed
      && mouseX > ((level3x * 100) + interval/2) - shapeDim/2
      && mouseX < ((level3x * 100) + interval/2) + shapeDim/2
      && mouseY > ((level3y * 100) + interval/2) - shapeDim/2
      && mouseY < ((level3y * 100) + interval/2) + shapeDim/2) {                                    // if the player clicks on the different object
      println("You win!");                                                                          // game over
      level3 = false;
    }
  }
}
