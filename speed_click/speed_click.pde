/*  
 speed_click
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean gameOver = false;                                                                      // whether the game is over or not
boolean shape1 = true;                                                                         // whether shape1 is alive or not
boolean shape2 = true;                                                                         // whether shape2 is alive or not
boolean shape3 = true;                                                                         // whether shape3 is alive or not
float x1, x2, x3, y1, y2, y3;                                                                  // x and y positions for each shape
int shapeDim = 50;                                                                             // width and height of each shape
int shape1count, shape2count, shape3count = 0;                                                 // counter to track number of fast clicks on each shape
int shape1time, shape2time, shape3time = 0;                                                    // initial click timer for each shape
int timeInterval = 200;                                                                        // max time, in milliseconds, in between clicks to be counted as fast
float destroyLevel = 10;                                                                       // number of fast clicks needed to destroy a shape

void setup() {
  size(400, 400);
  smooth();
  noStroke();
  x1 = random(0, width - shapeDim);                                                            // set random x position for shape1
  x2 = random(0, width - shapeDim);                                                            // set random x position for shape2
  x3 = random(0, width - shapeDim);                                                            // set random x position for shape3
  y1 = random(0, height - shapeDim);                                                           // set random y position for shape1
  y2 = random(0, height - shapeDim);                                                           // set random y position for shape2
  y3 = random(0, height - shapeDim);                                                           // set random y position for shape3
}

void draw() {
  background(255);
  if (shape1) {                                                                                // if shape1 is alive
    fill((shape1count/destroyLevel) * 200);                                                    // set the fill color based on how many fast clicks the shape has
    rect(x1, y1, shapeDim, shapeDim);                                                          // draw shape1
  }
  if (shape2) {                                                                                // if shape2 is alive
    fill((shape2count/destroyLevel) * 200);                                                    // set the fill color based on how many fast clicks the shape has
    rect(x2, y2, shapeDim, shapeDim);                                                          // draw shape2
  }
  if (shape3) {                                                                                // if shape3 is alive
    fill((shape3count/destroyLevel) * 200);                                                    // set the fill color based on how many fast clicks the shape has
    rect(x3, y3, shapeDim, shapeDim);                                                          // draw shape3
  }
}

void mousePressed() {                                                                          // when the mouse button is pressed
  if (gameOver == false) {                                                                     // if the game is not over
    if (mouseX > x1 && mouseX < x1 + shapeDim && mouseY > y1 && mouseY < y1 + shapeDim) {      // if the mouse press is on shape1
      if (shape1time != 0) {                                                                   // if shape 1 has already been pressed at least once
        if (millis() - shape1time < timeInterval) {                                            // if the press was within the timeInterval of a previous press
          shape1count++;                                                                       // increment the counter
        }
      }
      shape1time = millis();                                                                   // set the shape1 timer to the current time
    }
    if (mouseX > x2 && mouseX < x2 + shapeDim && mouseY > y2 && mouseY < y2 + shapeDim) {      // if the mouse press is on shape2
      if (shape2time != 0) {                                                                   // if shape 2 has already been pressed at least once
        if (millis() - shape2time < timeInterval) {                                            // if the press was within the timeInterval of a previous press
          shape2count++;                                                                       // increment the counter
        }
      }
      shape2time = millis();                                                                   // set the shape2 timer to the current time
    }
    if (mouseX > x3 && mouseX < x3 + shapeDim && mouseY > y3 && mouseY < y3 + shapeDim) {      // if the mouse press is on shape3
      if (shape3time != 0) {                                                                   // if shape 3 has already been pressed at least once
        if (millis() - shape3time < timeInterval) {                                            // if the press was within the timeInterval of a previous press
          shape3count++;                                                                       // increment the counter
        }
      }
      shape3time = millis();                                                                   // set the shape3 timer to the current time
    }
    if (shape1) {                                                                              // if shape1 is alive
      if (shape1count > destroyLevel) {                                                        // if the number of fast clicks on shape1 exceeds destroyLevel
        shape1 = false;                                                                        // destroy shape1
        println("shape 1 destroyed");
      }
    }
    if (shape2) {                                                                              // if shape2 is alive
      if (shape2count > destroyLevel) {                                                        // if the number of fast clicks on shape2 exceeds destroyLevel
        shape2 = false;                                                                        // destroy shape2
        println("shape 2 destroyed");
      }
    }
    if (shape3) {                                                                              // if shape3 is alive
      if (shape3count > destroyLevel) {                                                        // if the number of fast clicks on shape3 exceeds destroyLevel
        shape3 = false;                                                                        // destroy shape3
        println("shape 3 destroyed");
      }
    }
    if (shape1 == false && shape2 == false && shape3 == false) {                               // if all three shapes have been destroyed
      gameOver = true;                                                                         // the game is over
      println("You win!");
    }
  }
}