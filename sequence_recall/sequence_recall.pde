/*  
 sequence_recall
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

int buttonR = 50;                                                                          // radius of buttons
int[] buttonX = {50, 200, 350, 500, 650, 50, 200, 350, 500, 650};                          // x positions of buttons
int[] buttonY = {50, 50, 50, 50, 50, 200, 200, 200, 200, 200};                             // y positions of buttons
int numSteps = 5;                                                                          // number of steps in the sequence to recall
String sequence = "";                                                                      // String representing the sequence to recall
int currentStep = 0;                                                                       // step the player is currently trying to recall
String selectedSteps = "";                                                                 // String of the steps the player has already recalled
boolean playerWins = false;                                                                // whether or not the player has already won
int startTime;                                                                             // timer for displaying the sequence at the beginning of the sketch
int dispTime = 1000;                                                                       // length of time to display text messages
boolean message;                                                                           // whether or not to display a message
String messageText;                                                                        // String of message text
int messageTime;                                                                           // timer for displaying text messages

void setup() {
  size(800, 500);
  noStroke();
  textAlign(CENTER, CENTER);
  for (int i = 0; i < numSteps; i++) {
    sequence = sequence.concat(str(int(random(0, 10))));                                   // create a String of a sequence of random digits representing the steps to recall
  }
  println(sequence);
  startTime = millis();                                                                    // start the sequence display timer
}

void draw() {
  background(128);
  if (!((millis() - startTime) > dispTime)) {                                              // if the sequence display timer hasn't finished...
    text(sequence, 0, 350, width, 100);                                                    // ...display the sequence
  } else {
    for (int i = 0; i < buttonX.length; i++) {
      drawButton(buttonX[i], buttonY[i], buttonR, "Step " + i);                            // otherwise draw the buttons
    }
  }
  if (message) {                                                                           // if a message is to be displayed...
    text(messageText, 0, 350, width, 100);                                                 // ...display the message
    if (millis() - messageTime > dispTime) {                                               // if the message timer has finished...
      message = false;                                                                     // ...don't display the message any longer
    } 
  }
  if (playerWins) {                                                                        // if the player wins...
    text("You win!", 0, 350, width, 100);                                                  // ...display text
  }
}

void drawButton(int x, int y, int radius, String label) {                                  // the drawButton function needs an x position, y position, radius, and text label
  fill(0);
  ellipse(x + radius, y + radius, radius * 2, radius *2);                                  // draw an ellipse for the button
  fill(255);
  textAlign(CENTER, CENTER);
  text(label, x, y, radius * 2, radius * 2);                                               // display the button label text
}

void mousePressed() {                                                                      // when the mouse is pressed
  if ((millis() - startTime) > dispTime) {                                                 // if the sequence display timer isn't currently active
    for (int i = 0; i < buttonX.length; i++) {                                             // for all of the buttons
      if (mouseX > buttonX[i] && mouseX < buttonX[i] + (buttonR * 2) && mouseY > buttonY[i] && mouseY < buttonY[i] + (buttonR * 2)) {      // if the mouse pointer is within the area of one of the buttons
        if (currentStep < sequence.length()) {                                             // if the player hasn't recalled the entire sequence yet
          if (str(i).equals(str(sequence.charAt(currentStep)))) {                          // if the button pressed is the next step in the sequence
            selectedSteps = selectedSteps.concat(str(i));                                  // add the step to the String of the steps the player has already recalled
            currentStep++;                                                                 // increment the step counter
            if (currentStep == sequence.length()) {                                        // if the player has reached the end of the sequence
              message = false;
              playerWins = true;                                                           // the player wins
            } else {
              message = true;                                                              // otherwise display a message
              messageText = "Correct!";
              messageTime = millis();
            }
          } else {                                                                         // if the button pressed is not the next step in the sequence
            message = true;                                                                // display a message
            messageText = "Incorrect!";
            messageTime = millis();  
          }
        }
      }
    }
  }
}
