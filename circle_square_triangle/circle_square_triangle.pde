/*  
 circle_square_triangle
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

boolean selectShapeMode = true;                            // whether selectShape mode is active or not (when a player selects a shape)
boolean resultsMode = false;                               // whether results mode is active or not (when a winner is determined and displayed)
boolean playerTri, playerCircle, playerSquare = false;     // the three shapes the player can choose
int compShape;                                             // shape the computer chooses randomly
boolean compTri, compCircle, compSquare = false;           // the three shapes the computer can choose
boolean compWins, playerWins, drawGame = false;            // the three possible game outcomes
int startTime;                                             // timer for restarting the game once a winner has been displayed
int restartTime = 2000;                                    // amount of time in milliseconds to delay before restarting the game

void setup() {
  size(600, 300);
  smooth();
  noStroke();
  println("Triangle beats circle, circle beats square, and square beats triangle. After you choose a shape, the computer's selection (as well as the winner) will be revealed!");
}

void draw() {
  background(255);
  fill(0);
  textSize(24);
  textAlign(CENTER);
  text("Computer", 0, 20, 300, 300);
  text("You", 300, 20, 300, 300);
  if (selectShapeMode) {                                   // if selectShape mode is active, draw the shapes the player can select
    triangle(350, 225, 325, 275, 375, 275);
    ellipse(450, 250, 50, 50);
    rect(525, 225, 50, 50);
  }
  if (resultsMode) {                                       // if results mode is active
    if (compTri) {                                         // if the computer chose a triangle
      triangle(150, 100, 100, 200, 200, 200);              // draw a triangle
    }
    if (compCircle) {                                      // if the computer chose a circle
      ellipse(150, 150, 100, 100);                         // draw a circle
    }
    if (compSquare) {                                      // if the computer chose a square
      rect(100, 100, 100, 100);                            // draw a square
    }
    if (playerTri) {                                       // if the player chose a triangle
      triangle(450, 100, 400, 200, 500, 200);              // draw a triangle
    }
    if (playerCircle) {                                    // if the player chose a circle
      ellipse(450, 150, 100, 100);                         // draw a circle
    }
    if (playerSquare) {                                    // if the player chose a square
      rect(400, 100, 100, 100);                            // draw a square
    }
    if (compWins) {                                        // display if the computer wins
      text("WINNER!", 0, 240, 300, 300);
    } 
    else if (playerWins) {                                 // display if the player wins
      text("WINNER!", 300, 240, 300, 300);
    } 
    else if (drawGame) {                                   // display if nobody wins
      text("DRAW!", 0, 240, 600, 300);
    }
    if ((millis() - startTime) > restartTime) {            // once the timer has ended, reset all of the variables to start the game again
      compWins = false;
      playerWins = false;
      drawGame = false;
      playerTri = false;
      playerCircle = false;
      playerSquare = false;
      compTri = false;
      compCircle = false;
      compSquare = false;
      resultsMode = false;
      selectShapeMode = true;
    }
  }
}

void mousePressed() {                                      // when the mouse button is pressed
  if (selectShapeMode) {                                   // if selectShape mode is currently active
    if (mouseY > 225 && mouseY < 275) {                    // if the mouse pointer y-coordinate is greater than 225 and less than 275
      if (mouseX > 325 && mouseX < 400) {                  // if the mouse pointer x-coordinate is greater than 325 and less than 400
        playerTri = true;                                  // the player chooses triangle
      }
      if (mouseX > 400 && mouseX < 500) {                  // if the mouse pointer x-coordinate is greater than 400 and less than 500
        playerCircle = true;                               // the player chooses circle
      }
      if (mouseX > 500 && mouseX < 575) {                  // if the mouse pointer x-coordinate is greater than 500 and less than 575
        playerSquare = true;                               // the player chooses square
      }
      if (mouseX > 325 && mouseX < 575) {                  // if the mouse pointer x-coordinate is greater than 325 and less than 575, meaning the player selected one of the three shapes
        selectShapeMode = false;                           // deactivate selectShape mode
        resultsMode = true;                                // activate results mode
        compShape = round(random(.5, 3.49));               // a random number determines the computer's shape
        if (compShape == 1) {                              // if the random number is 1
          compTri = true;                                  // the computer chooses triangle
        } 
        else if (compShape == 2) {                         // if the random number is 2
          compCircle = true;                               // the computer chooses circle
        } 
        else if (compShape == 3) {                         // if the random number is 3
          compSquare = true;                               // the computer chooses square
        }
        if (compTri && playerCircle) {                     // if the computer chooses triangle and the player chooses circle
          compWins = true;                                 // computer wins
        } 
        else if (compTri && playerSquare) {                // if the computer chooses triangle and the player chooses square
          playerWins = true;                               // player wins
        } 
        else if (compCircle && playerTri) {                // if the computer chooses circle and the player chooses triangle
          playerWins = true;                               // player wins
        } 
        else if (compCircle && playerSquare) {             // if the computer chooses circle and the player chooses square
          compWins = true;                                 // computer wins
        } 
        else if (compSquare && playerTri) {                // if the computer chooses square and the player chooses triangle
          compWins = true;                                 // computer wins
        } 
        else if (compSquare && playerCircle) {             // if the computer chooses square and the player chooses circle
          playerWins = true;                               // player wins
        } 
        else {                                             // the game is a draw (both the player and computer choose the same shape)
          drawGame = true;
        }
        startTime = millis();                              // start the timer to restart the game
      }
    }
  }
}