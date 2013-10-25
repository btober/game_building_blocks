/*  
 dodge_enemies
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */
 
float x1, x2, x3, y1, y2, y3, playerX, playerY;            // x and y positions for three enemies and player
float speed1, speed2, speed3;                              // enemy speeds
int enemyDim = 50;                                         // size of enemies (width and height of square)
int playerDim = 25;                                        // size of player (width and height of square)
int incVal = 10;                                           // number of pixels that the player moves each time the up or down arrow is pressed 
boolean playMode = true;                                   // whether play mode is active or not (when player is alive and has not yet won the game)
int startTime;                                             // timer for specifying length of game
int timer = 30000;                                         // amount of time in milliseconds the player must remain alive to win
 
void setup() {
  size(500, 500);
  smooth();
  noStroke();
  playerX = 10;                                            // initial x position of player
  playerY = 10;                                            // initial y position of player
  x1 = width;                                              // x position of enemy 1 starts at the right side of the window
  x2 = width;                                              // x position of enemy 2 starts at the right side of the window
  x3 = width;                                              // x position of enemy 3 starts at the right side of the window
  y1 = random(0, height - enemyDim);                       // random starting y position of enemy 1 
  y2 = random(0, height - enemyDim);                       // random starting y position of enemy 2
  y3 = random(0, height - enemyDim);                       // random starting y position of enemy 3
  speed1 = random(1.5, 10.5);                              // random starting speed of enemy 1
  speed2 = random(1.5, 10.5);                              // random starting speed of enemy 2
  speed3 = random(1.5, 10.5);                              // random starting speed of enemy 3
  startTime = millis();                                    // start the game timer
  println("Use the up and down arrow keys to avoid the enemies moving toward you. If you're alive when the timer runs out, you win!");
}

void draw() {
  background(255);
  fill(0);
  rect(x1, y1, enemyDim, enemyDim);                        // draw enemy 1
  rect(x2, y2, enemyDim, enemyDim);                        // draw enemy 2
  rect(x3, y3, enemyDim, enemyDim);                        // draw enemy 3
  if (playMode) {                                          // if play mode is active
    x1 -= speed1;                                          // decrease the x position of enemy 1 by enemy 1's speed (move it to the left)
    if (x1 < -enemyDim) {                                  // if enemy 1 has disappeared off the left side of the window
      x1 = width;                                          // reset enemy 1's x position to the right side of the window
      y1 = random(0, height - enemyDim);                   // give enemy 1 a new random y position
      speed1 = random(1.5, 10.5);                          // give enemy 1 a new random speed
    }
    x2 -= speed2;                                          // decrease the x position of enemy 2 by enemy 2's speed (move it to the left)
    if (x2 < -enemyDim) {                                  // if enemy 2 has disappeared off the left side of the window
      x2 = width;                                          // reset enemy 2's x position to the right side of the window
      y2 = random(0, height - enemyDim);                   // give enemy 2 a new random y position
      speed2 = random(1.5, 10.5);                          // give enemy 2 a new random speed
    }
    x3 -= speed3;                                          // decrease the x position of enemy 3 by enemy 3's speed (move it to the left)
    if (x3 < -enemyDim) {                                  // if enemy 3 has disappeared off the left side of the window
      x3 = width;                                          // reset enemy 3's x position to the right side of the window
      y3 = random(0, height - enemyDim);                   // give enemy 3 a new random y position
      speed3 = random(1.5, 10.5);                          // give enemy 2 a new random speed
    }
    if ((x1 < playerX + playerDim && y1 < playerY + playerDim && y1 + enemyDim > playerY) ||        // if the left side of enemy 1 touches or overlaps the right side of the player or
     (x2 < playerX + playerDim && y2 < playerY + playerDim && y2 + enemyDim > playerY) ||           // if the left side of enemy 2 touches or overlaps the right side of the player or
    (x3 < playerX + playerDim && y3 < playerY + playerDim && y3 + enemyDim > playerY)) {            // if the left side of enemy 3 touches or overlaps the right side of the player
      playMode = false;                                    // the game is over
      println("You lose!");                                // player loses
    }
    if (millis() - startTime > timer) {                    // if time runs out
      playMode = false;                                    // the game is over
      println("You win!");                                 // player wins
    }
    text(str(ceil((timer - (millis() - startTime))/1000.0)) + " seconds remain", 375, 20);          // display the amount of time remaining
  }
  fill(255, 0, 0);
  rect(playerX, playerY, playerDim, playerDim);            // draw the player
}

void keyPressed() {                                        // when a key is pressed
  if (playMode) {                                          // if play mode is active
    if ((key == CODED) && (keyCode == DOWN)) {             // if the key is the down arrow
      playerY += incVal;                                   // increase the y position of the player by the number of pixels specified by incVal (move the player down)
      if (playerY > height - 10) {                         // if the player has moved beyond the bottom of the screen
        playerY -= incVal;                                 // move the player back up
      }
    }
    if ((key == CODED) && (keyCode == UP)) {               // if the key is the up arrow
      playerY -= incVal;                                   // decrease the y position of the player by the number of pixels specified by incVal (move the player up)
      if (playerY < 10) {                                  // if the player has moved beyond the top of the screen
        playerY += incVal;                                 // move the player back down
      }
    }
  }
}
