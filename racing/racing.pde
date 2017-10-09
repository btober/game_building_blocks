/*  
 racing
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean waitingMode = true;                                     // whether waiting mode is active or not
boolean countdownMode = false;                                  // whether countdown mode is active or not
boolean playingMode = false;                                    // whether playing mode is active or not
int startTime;                                                  // timer for countdown mode
int dispTime = 4000;                                            // length of countdown timer in milliseconds
int textTime;                                                   // amount of countdown time remaining
boolean winner = false;                                         // whether there is a winner yet or not
boolean aWins = false;                                          // whether player A is the winner or not
boolean bWins = false;                                          // whether player B is the winner or not
int aYPos = 50;                                                 // starting Y position for player a
int bYPos = 50;                                                 // starting Y position for player b
boolean aKey1 = true;                                           // whether the next key for player a to press is 'a' or not
boolean bKey1 = true;                                           // whether the next key for player b to press is 'k' or not

void setup() {
  size(600, 300);
  smooth();
  noStroke();
  println("After pressing \"s\" to begin the game, the first player to move their square to the bottom of the sketch window after the \"0\" of the countdown disappears, wins! Player A moves by pressing \"a\" and \"s\" consecutively, while player B moves with \"k\" and \"l\".");
}

void draw() {
  background(255);
  fill(0);
  textSize(24);
  textAlign(CENTER);
  if (waitingMode) {                                            // if waiting mode is active
    text("Press \"s\" to begin", 0, 135, 600, 300);             // display a message telling the players to press the 's' key
  }
  if (countdownMode) {                                          // if countdown mode is active
    textTime = int((dispTime - (millis() - startTime))/1000);   // calculate the countdown time remaining
    text(str(textTime), 0, 135, 600, 300);                      // display the countdown time remaining
    if ((millis() - startTime) > dispTime) {                    // if the countdown has finished
      countdownMode = false;                                    // end countdown mode
      playingMode = true;                                       // being playing mode
    }
  }
  if (playingMode) {                                            // if playing mode is active
    fill(128);
    rect(0, 0, width, 50);                                      // draw bar at top of sketch window
    rect(140, aYPos, 20, 20);                                   // draw player a
    rect(440, bYPos, 20, 20);                                   // draw player b
    if (aWins) {                                                // if player A wins
      fill(0, 0, 255);
      rect(0, 0, 300, 300);
      fill(255);
      text("WINNER", 0, 165, 300, 300);                         // display player A as winner
    } 
    else if (bWins) {                                           // if player B wins
      fill(255, 0, 0);
      rect(300, 0, 600, 300);
      fill(255);
      text("WINNER", 300, 165, 300, 300);                       // display player B as winner
    }
    fill(0);
    text("Player A", 0, 10, 300, 50);
    text("Player B", 300, 10, 300, 50);
  }
}

void keyPressed() {                                             // when a key is pressed
  if (waitingMode && key == 's') {                              // if waiting mode is active and the key pressed was 's'
    waitingMode = false;                                        // end waiting mode
    countdownMode = true;                                       // start countdown mode
    startTime = millis();                                       // start the countdown timer
  }
  if (playingMode && winner == false) {                         // if playing mode is active and there's no winner yet
    if (key == 'a' && aKey1) {                                  // if the key pressed was 'a' and the last player a key pressed was 's'
      aYPos++;                                                  // move the player a indicator
      if (aYPos >= height - 20) {                               // if player a is touching the bottom of the sketch window
        winner = true;                                          // player a wins!
        aWins = true;  
      }
      aKey1 = false;
    } else if (key == 's' && !aKey1) {                          // if the key pressed was 's' and the last player a key pressed was 'a' 
      aYPos++;
      if (aYPos >= height - 20) {
        winner = true;
        aWins = true;  
      }
      aKey1 = true;
    }
    if (key == 'k' && bKey1) {                                  // if the key pressed was 'k' and the last player a key pressed was 'l'
      bYPos++;                                                  // move the player b indicator
      if (bYPos >= height - 20) {                               // if player b is touching the bottom of the sketch window
        winner = true;                                          // player b wins!
        bWins = true;  
      }
      bKey1 = false;
    } else if (key == 'l' && !bKey1) {                          // if the key pressed was 'l' and the last player a key pressed was 'k'
      bYPos++;
      if (bYPos >= height - 20) {
        winner = true;
        bWins = true;  
      }
      bKey1 = true;
    }
  }
}