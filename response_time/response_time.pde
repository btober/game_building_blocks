/*  
 response_time
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean waitingMode = true;                                    // whether waiting mode is active or not
boolean countdownMode = false;                                 // whether countdown mode is active or not
boolean playingMode = false;                                   // whether playing mode is active or not
int startTime;                                                 // timer for countdown mode
int dispTime = 4000;                                           // length of countdown timer in milliseconds
int textTime;                                                  // amount of countdown time remaining
int playStart;                                                 // time when playing mode starts
float responseTime;                                            // the length of time between the start of playing mode and the first response
boolean winner = false;                                        // whether there is a winner yet or not
boolean aWins = false;                                         // whether player A is the winner or not
boolean bWins = false;                                         // whether player B is the winner or not

void setup() {
  size(600, 300);
  smooth();
  noStroke();
  println("After pressing \"s\" to begin the game, the first player to press their respective key (\"a\" for player A and \"l\" for player B) after the \"0\" of the countdown disappears, wins!");
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
      playStart = millis();                                     // begin the response timer
      countdownMode = false;                                    // end countdown mode
      playingMode = true;                                       // being playing mode
    }
  }
  if (playingMode) {                                            // if playing mode is active
    if (aWins) {                                                // if player A wins
      fill(0, 0, 255);
      rect(0, 0, 300, 300);
      fill(255);
      text("WINNER", 0, 165, 300, 300);                         // display player A as winner
      text(str(responseTime) + " seconds", 0, 195, 300, 300);   // display response time
    } 
    else if (bWins) {                                           // if player B wins
      fill(255, 0, 0);
      rect(300, 0, 600, 300);
      fill(255);
      text("WINNER", 300, 165, 300, 300);                       // display player B as winner
      text(str(responseTime) + " seconds", 300, 195, 300, 300); // display response time
    }
    fill(0);
    text("Player A", 0, 135, 300, 300);
    text("Player B", 300, 135, 300, 300);
  }
}

void keyPressed() {                                             // when a key is pressed
  if (waitingMode && key == 's') {                              // if waiting mode is active and the key pressed was 's'
    waitingMode = false;                                        // end waiting mode
    countdownMode = true;                                       // start countdown mode
    startTime = millis();                                       // start the countdown timer
  }
  if (playingMode && winner == false) {                         // if playing mode is active and there's no winner yet
    if (key == 'a' || key == 'l') {                             // if the key pressed was 'a' or 'l'
      winner = true;                                            // someone wins
      responseTime = (millis() - playStart)/1000.0;             // calculates the response time of the first player to hit their key
    }
    if (key == 'a') {                                           // if the key pressed was 'a'
      aWins = true;                                             // player A wins
    } 
    else if (key == 'l') {                                      // if the key pressed was 'l'
      bWins = true;                                             // player B wins
    }
  }
}
