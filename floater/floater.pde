/*  
 floater
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

int yPos = 550;                                              // starting y position for the player
int incVal = 5;                                              // the number of pixels the player should move each frame when the space bar is pressed
boolean topIsCurrentGoal = true;                             // whether or not the player is currently trying to reach the top goal

void setup() {
  size(400, 600);
  noStroke();
}

void draw() {
  background(255);
  if (topIsCurrentGoal) {                                    // if the player is currently trying to reach the top goal
    fill(0, 0, 255);                                         // draw it in blue
  } else {                                                   // otherwise
    fill(128);                                               // draw it in gray
  }
  rect(150, 25, 100, 50);                                    // draw top goal
  if (!topIsCurrentGoal) {                                   // if the player is currently trying to reach the bottom goal
    fill(0, 0, 255);                                         // draw it in blue
  } else {                                                   // otherwise
    fill(128);                                               // draw it in gray
  }
  rect(150, 525, 100, 50);                                   // draw bottom goal
  fill(0);
  ellipse(200, yPos, 50, 50);                                // draw player
  if (keyPressed && key == ' ') {                            // if the player is pressing the space bar             
    yPos -= incVal;                                          // decrease the player y position by incVal each frame (move player up)
  } else {                                                   // otherwise
    yPos += incVal;                                          // increase the player y position by incVal each frame (move player down)
  }
  if (yPos < 50) {                                           // if the player reaches the top goal, don't let it move up any further
    yPos = 50;
    topIsCurrentGoal = false;                                // switch the goal the player is trying to reach
  }
  if (yPos > 550) {                                          // if the player reaches the bottom goal, don't let it move down any further
    yPos = 550;
    topIsCurrentGoal = true;                                 // switch the goal the player is trying to reach
  }
}
