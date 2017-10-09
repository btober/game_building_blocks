/*  
 item_collecting
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean shape1 = true;                                           // whether shape1 is visible or not
boolean shape2 = true;                                           // whether shape2 is visible or not
boolean shape3 = true;                                           // whether shape3 is visible or not
float x1, x2, x3, y1, y2, y3;                                    // x and y positions of shapes
float x1speed, x2speed, x3speed, y1speed, y2speed, y3speed;      // x and y speeds of shapes
int radius = 25;                                                 // radius of shapes
int shapeCount = 0;                                              // counter to track how many shapes have been collected

void setup() {
  size(400, 400);
  smooth();
  noStroke();
  x1 = random(0, width - radius * 2);                            // set random initial x position for shape1
  x2 = random(0, width - radius * 2);                            // set random initial x position for shape2
  x3 = random(0, width - radius * 2);                            // set random initial x position for shape3
  y1 = random(0, height - radius * 2);                           // set random initial y position for shape1
  y2 = random(0, height - radius * 2);                           // set random initial y position for shape2
  y3 = random(0, height - radius * 2);                           // set random initial y position for shape3
  x1speed = random(.5, 1.5);                                     // set random x speed for shape1
  x2speed = random(.5, 1.5);                                     // set random x speed for shape2
  x3speed = random(.5, 1.5);                                     // set random x speed for shape3
  y1speed = random(.5, 1.5);                                     // set random y speed for shape1
  y2speed = random(.5, 1.5);                                     // set random y speed for shape2
  y3speed = random(.5, 1.5);                                     // set random y speed for shape3
  println("Collect all three shapes with your mouse pointer to win!");
}

void draw() {
  background(255);
  fill(128);
  if (shape1) {                                                  // if shape1 is visible
    ellipse(x1, y1, radius * 2, radius * 2);                     // draw shape1
    if (mouseX > x1 - radius && mouseX < x1 + radius && mouseY > y1 - radius && mouseY < y1 + radius) {              // if the mouse pointer intersects shape1
      shape1 = false;                                            // hide shape1 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
    x1 += x1speed;                                               // change the x position of shape1 using its speed value
    if (x1 > width - radius || x1 < radius) {                    // if shape1 hits the right or left side of the window
      x1speed = -x1speed;                                        // invert the x speed of shape1 (change its horizontal direction)
    }
    y1 += y1speed;                                               // change the y position of shape1 using its speed value
    if (y1 > height - radius || y1 < radius) {                   // if shape1 hits the bottom or top of the window
      y1speed = -y1speed;                                        // invert the y speed of shape1 (change its vertical direction)
    }
  }
  if (shape2) {                                                  // if shape2 is visible
    ellipse(x2, y2, radius * 2, radius * 2);                     // draw shape2
    if (mouseX > x2 - radius && mouseX < x2 + radius && mouseY > y2 - radius && mouseY < y2 + radius) {              // if the mouse pointer intersects shape2
      shape2 = false;                                            // hide shape2 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
    x2 += x2speed;                                               // change the x position of shape2 using its speed value
    if (x2 > width - radius || x2 < radius) {                    // if shape2 hits the right or left side of the window
      x2speed = -x2speed;                                        // invert the x speed of shape2 (change its horizontal direction)
    }
    y2 += y2speed;                                               // change the y position of shape2 using its speed value
    if (y2 > height - radius || y2 < radius) {                   // if shape2 hits the bottom or top of the window
      y2speed = -y2speed;                                        // invert the y speed of shape2 (change its vertical direction)
    }
  }
  if (shape3) {                                                  // if shape3 is visible
    ellipse(x3, y3, radius * 2, radius * 2);                     // draw shape3
    if (mouseX > x3 - radius && mouseX < x3 + radius && mouseY > y3 - radius && mouseY < y3 + radius) {              // if the mouse pointer intersects shape3
      shape3 = false;                                            // hide shape3 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
    x3 += x3speed;                                               // change the x position of shape3 using its speed value
    if (x3 > width - radius || x3 < radius) {                    // if shape3 hits the right or left side of the window
      x3speed = -x3speed;                                        // invert the x speed of shape3 (change its horizontal direction)
    }
    y3 += y3speed;                                               // change the y position of shape3 using its speed value
    if (y3 > height - radius || y3 < radius) {                   // if shape3 hits the bottom or top of the window
      y3speed = -y3speed;                                        // invert the y speed of shape3 (change its vertical direction)
    }
  }
  fill(0);
  ellipse(mouseX, mouseY, 5, 5);                                 // draw the collector at the mouse pointer location
  if (shapeCount < 3) {                                          // if fewer than 3 shapes have been collected
    text("Items collected: " + shapeCount, 10, 20);              // display the number of shapes collected
  } 
  else {
    text("You win!", 10, 20);                                    // otherwise the player wins
  }
}