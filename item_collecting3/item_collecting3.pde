/*  
 item_collecting3
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean shape1 = true;                                           // whether shape1 is visible or not
boolean shape2 = true;                                           // whether shape2 is visible or not
boolean shape3 = true;                                           // whether shape3 is visible or not
float x1, x2, x3, y1, y2, y3;                                    // x and y positions of shapes
int shape1timer;                                                 // the length of time shape1 will remain alive, set randomly in setup()
int shape2timer;                                                 // the length of time shape2 will remain alive, set randomly in setup()
int shape3timer;                                                 // the length of time shape3 will remain alive, set randomly in setup()
float startTime;                                                 // the starting time for the timer
int radius = 25;                                                 // radius of shapes
int shapeCount = 0;                                              // counter to track how many shapes have been collected
int missedShapes = 0;                                            // counter to track how many shapes have disappeared without being collected

int playerX = 50;                                                // starting x position for the collector
int playerY = 50;                                                // starting y position for the collector
int incVal = 10;                                                 // number of pixels each key press will move the collector

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
  shape1timer = int(random(10000, 20000));                       // set a random length of time shape1 will be alive, from 10 to 20 seconds
  shape2timer = int(random(10000, 20000));                       // set a random length of time shape2 will be alive, from 10 to 20 seconds
  shape3timer = int(random(10000, 20000));                       // set a random length of time shape2 will be alive, from 10 to 20 seconds
  startTime = millis();                                          // start the timer
  println("Use the keyboard to collect all three shapes before they fade away!");
}

void draw() {
  background(255);
  if (shape1) {                                                  // if shape1 is visible
    if (millis() - startTime < shape1timer) {                    // if shape1 is still alive
      fill((((millis() - startTime)/shape1timer)) * 255);        // set the fill value proportional to the amount of life left
    } else {                                                     // otherwise, when time is up
      fill(255);
      shape1 = false;                                            // shape1 should no longer be visible
      missedShapes++;                                            // increase the number of missed shapes
    }
    ellipse(x1, y1, radius * 2, radius * 2);                     // draw shape1
    if (playerX > x1 - radius && playerX < x1 + radius && playerY > y1 - radius && playerY < y1 + radius) {              // if the collector intersects shape1
      shape1 = false;                                            // hide shape1 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
  }
  if (shape2) {                                                  // if shape2 is visible
    if (millis() - startTime < shape2timer) {                    // if shape2 is still alive
      fill((((millis() - startTime)/shape2timer)) * 255);        // set the fill value proportional to the amount of life left
    } else {                                                     // otherwise, when time is up
      fill(255);
      shape2 = false;                                            // shape2 should no longer be visible
      missedShapes++;                                            // increase the number of missed shapes
    }
    ellipse(x2, y2, radius * 2, radius * 2);                     // draw shape2
    if (playerX > x2 - radius && playerX < x2 + radius && playerY > y2 - radius && playerY < y2 + radius) {              // if the collector intersects shape2
      shape2 = false;                                            // hide shape2 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
  }
  if (shape3) {                                                  // if shape3 is visible
    if (millis() - startTime < shape3timer) {                    // if shape3 is still alive
      fill((((millis() - startTime)/shape3timer)) * 255);        // set the fill value proportional to the amount of life left
    } else {                                                     // otherwise, when time is up
      fill(255);
      shape3 = false;                                            // shape3 should no longer be visible
      missedShapes++;                                            // increase the number of missed shapes
    }
    ellipse(x3, y3, radius * 2, radius * 2);                     // draw shape3
    if (playerX > x3 - radius && playerX < x3 + radius && playerY > y3 - radius && playerY < y3 + radius) {              // if the collector intersects shape3
      shape3 = false;                                            // hide shape3 because it has been collected
      shapeCount++;                                              // increase the number of shapes collected
    }
  }
  fill(0);
  ellipse(playerX, playerY, 5, 5);                               // draw the collector
  if (shapeCount + missedShapes < 3) {                           // if fewer than 3 shapes have been collected and there are still shapes that the player hasn't missed
    text("Items collected: " + shapeCount, 10, 20);              // display the number of shapes collected
  } else if (missedShapes > 0 && shapeCount + missedShapes == 3) {
    text("Game over!", 10, 20);                                  // otherwise the player loses
  } else {
    text("You win!", 10, 20);                                    // otherwise the player wins
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {                                         // if the player presses the up key
      playerY -= incVal;                                         // move the collector up by decreasing the playerY value by incVal
      if (playerY < 0) {                                         // don't let the collector move off the top of the window
        playerY = 0;
      }
    }
    if (keyCode == DOWN) {                                       // if the player presses the down key
      playerY += incVal;                                         // move the collector down by increasing the playerY value by incVal
      if (playerY > height) {                                    // don't let the collector move off the bottom of the window
        playerY = height;
      }
    }
    if (keyCode == LEFT) {                                       // if the player presses the left key
      playerX -= incVal;                                         // move the collector left by decreasing the playerX value by incVal
      if (playerX < 0) {                                         // don't let the collector move off the left side of the window
        playerX = 0;
      }
    }
    if (keyCode == RIGHT) {                                      // if the player presses the right key
      playerX += incVal;                                         // move the collector right by increasing the playerX value by incVal
      if (playerX > width) {                                     // don't let the collector move off the right side of the window
        playerX = width;
      }
    }
  }
}
