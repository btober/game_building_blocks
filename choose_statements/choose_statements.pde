/*  
 choose_statements
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

String[] statements;                                                   // stores the statement information from the text file
int currentStatement;                                                  // a random number to choose a statement
String[] splitStatement;                                               // stores the individual components of each statement
int order;                                                             // a random number to choose the order in which statement components are displayed
int numCorrect;                                                        // counts how many correct selections the player has made
boolean playing = true;                                                // whether the game is currently being played or not

void setup() {
  size(600, 500);
  noStroke();
  statements = loadStrings("statements.txt");                          // load the text file
  getNewStatement();                                                   // run the getNewStatement function (see below)
  println("Choose the compliments!");
}

void draw() {
  background(255);
  textSize(14);
  textAlign(CENTER, CENTER);
  if (playing) {                                                       // if the game is in progress
    fill(128);
    rect(200, 100, 200, 50);
    rect(50, 200, 500, 100);
    rect(50, 350, 500, 100);
    fill(0);
    text("Number correct: " + numCorrect, 200, 25, 200, 50);           // display the number of correct responses
    text(splitStatement[0], 200, 100, 200, 50);                        // display the object name
    if (order == 0) {                                                  // if the first component of the statement is to be displayed first
      text(splitStatement[1], 50, 200, 500, 100);
      text(splitStatement[2], 50, 350, 500, 100);
    } else {                                                           // otherwise the second component of the statement should be displayed first
      text(splitStatement[2], 50, 200, 500, 100);
      text(splitStatement[1], 50, 350, 500, 100);
    }
  } else {                                                             // if the game is no longer in progress
    fill(0);
    text("Game over!", 0, 0, width, height);                           // display "game over" message
  }
}

void mousePressed() {                                                  // when the mouse is pressed
  if (mouseX > 50 && mouseX < width - 50) {
    if (mouseY > 200 && mouseY < 300) {                                // if the player clicks on the first button
      if (order == 0) {                                                // if the first component of the statement is to be displayed first                                    
        numCorrect++;                                                  // increase the number of correct responses
        getNewStatement();                                             // display a new statement
      } else {
        playing = false;                                               // otherwise, game over
      }
    }
    if (mouseY > 350 && mouseY < 450) {                                // if the player clicks on the second button
      if (order == 0) {                                                // if the second component of the statement is to be displayed first
        playing = false;                                               // game over
      } else {
        numCorrect++;                                                  // otherwise, increase the number of correct responses
        getNewStatement();                                             // display a new statement
      }
    }
  }
}

void getNewStatement() {
  currentStatement = int(random(0, statements.length));                // generate a new random number to select a statement
  splitStatement = split(statements[currentStatement], ", ");          // break the statement into its components
  order = int(random(0, 2));                                           // choose the order in which the components are displayed
}

