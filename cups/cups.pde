/*  
 cups
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

int x0Pos = 100;                                                                  // starting x position for cup 0
int x1Pos = 275;                                                                  // starting x position for cup 1
int x2Pos = 450;                                                                  // starting x position for cup 2
int x0Dir = 1;                                                                    // starting x direction for cup 0
int x1Dir = 1;                                                                    // starting x direction for cup 1
int x2Dir = 1;                                                                    // starting x direction for cup 2
int x0Speed, x1Speed, x2Speed;                                                    // speed variables, set randomly in setup()
int diameter = 150;                                                               // diameter of circles
int randomCup;                                                                    // a randomly chosen cup, set in setup()
boolean showCup = true;                                                           // whether or not to show the chosen cup
boolean timerRunning = true;                                                      // whether or not the first timer (to show the chosen cup) is running
int startTime;                                                                    // when the first timer is started
int timerLength = 3000;                                                           // the length, in milliseconds, of the first timer
boolean moveCups = false;                                                         // whether or not to move the cups
boolean timer2Running = false;                                                    // whether or not the second timer (to move the cups) is running
int startTime2;                                                                   // when the second timer is started
int timerLength2 = 5000;                                                          // the length, in milliseconds, of the second timer
boolean timeToChoose = false;                                                     // whether or not the cups have stopped moving and the player must pick one

void setup() {
  size(550, 200);
  noStroke();
  randomCup = int(random(3));                                                     // choose a random cup
  startTime = millis();                                                           // start the first timer
  x0Speed = int(random(10, 100));                                                 // set the speed for cup 0
  x1Speed = int(random(10, 100));                                                 // set the speed for cup 1
  x2Speed = int(random(10, 100));                                                 // set the speed for cup 2
  println("Click on the indicated circle after they have been mixed up!");
}

void draw() {
  background(255);
  if (millis() - startTime > timerLength && timerRunning) {                       // if the first timer has finished
    timerRunning = false;
    showCup = false;                                                              // don't show the chosen cup any more
    timer2Running = true;                                                         // start the second timer
    startTime2 = millis();
    moveCups = true;                                                              // move the cups
  }
  if (millis() - startTime2 > timerLength2 && timer2Running) {                    // if the second timer has finished
    timer2Running = false;
    moveCups = false;                                                             // stop moving the cups
    timeToChoose = true;                                                          // allow the player to select a cup (see mousePressed())
    if (x0Pos == min(x0Pos, x1Pos, x2Pos)) {                                      // the following if structures align the cup positions to the starting options.
      x0Pos = 100;                                                                // ...then x0Pos = 100
      if (x1Pos == min(x1Pos, x2Pos)) {                                           // if x1Pos is the minimum of the two remaining cups...
        x1Pos = 275;
        x2Pos = 450;
      } else {
        x1Pos = 450;
        x2Pos = 275;
      }
    }
    if (x1Pos == min(x0Pos, x1Pos, x2Pos)) {
      x1Pos = 100;
      if (x0Pos == min(x0Pos, x2Pos)) {
        x0Pos = 275;
        x2Pos = 450;
      } else {
        x0Pos = 450;
        x2Pos = 275;
      }
    }
    if (x2Pos == min(x0Pos, x1Pos, x2Pos)) {
      x2Pos = 100;
      if (x0Pos == min(x0Pos, x1Pos)) {
        x0Pos = 275;
        x1Pos = 450;
      } else {
        x0Pos = 450;
        x1Pos = 275;
      }
    }
  }
  if (randomCup == 0 && showCup) {                                                // if cup 0 is the chosen cup and it should be shown
    fill(255, 0, 0);                                                              // draw it in red
  } else {                                                                        // otherwise
    fill(0);                                                                      // draw it in black
  }
  ellipse(x0Pos, 100, diameter, diameter);                                        // draw cup 0
  if (randomCup == 1 && showCup) {                                                // cup 1...
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  ellipse(x1Pos, 100, diameter, diameter);
  if (randomCup == 2 && showCup) {                                                // cup 2...
    fill(255, 0, 0);
  } else {
    fill(0);
  }
  ellipse(x2Pos, 100, diameter, diameter);
  if (moveCups) {                                                                 // if the cups are moving
    x0Pos += x0Speed * x0Dir;                                                     // change x0Pos
    if ((x0Pos > width - diameter/2) || (x0Pos < diameter/2)) {                   // don't let cup 0 leave the display window
      x0Dir = -x0Dir;
    }
    x1Pos += x1Speed * x1Dir;                                                     // change x1Pos
    if ((x1Pos > width - diameter/2) || (x1Pos < diameter/2)) {                   // don't let cup 1 leave the display window
      x1Dir = -x1Dir;
    }
    x2Pos += x2Speed * x2Dir;                                                     // change x2Pos
    if ((x2Pos > width - diameter/2) || (x2Pos < diameter/2)) {                   // don't let cup 2 leave the display window
      x2Dir = -x2Dir;
    }
  }
}

void mousePressed() {                                                             // when the mouse is pressed
  if (timeToChoose) {                                                             // if the player needs to select a cup
    if (dist(mouseX, mouseY, x0Pos, 100) <= diameter/2) {                         // if the player clicks on cup 0
      timeToChoose = false;                                                       // no more choices are allowed
      showCup = true;                                                             // show the correct cup
      if (randomCup == 0) {                                                       // if the randomly selected cup was cup 0
        println("Correct!");                                                      // display a "correct" message in the console
      } else {                                                                    // otherwise
        println("Sorry, wrong choice!");                                          // display an incorrect message in the console
      }
    }
    if (dist(mouseX, mouseY, x1Pos, 100) <= diameter/2) {                         // if the player clicks on cup 1
      timeToChoose = false;
      showCup = true;
      if (randomCup == 1) {
        println("Correct!");
      } else {
        println("Sorry, wrong choice!");
      }
    }
    if (dist(mouseX, mouseY, x2Pos, 100) <= diameter/2) {                         // if the player clicks on cup 2
      timeToChoose = false;
      showCup = true;
      if (randomCup == 2) {
        println("Correct!");
      } else {
        println("Sorry, wrong choice!");
      }
    }
  }
}

