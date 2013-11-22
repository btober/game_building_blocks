/*  
 shooter
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */
 
int playerX = 300;                                                          // x position of the shooter
int playerY = 300;                                                          // y position of the shooter
int playerDim = 50;                                                         // size of the shooter
int shootRad = 50;                                                          // size of the shooter barrel
float shootAngle;                                                           // angle (position) of shooter barrel
boolean playing = true;                                                     // whether or not the player is still trying to shoot enemies
boolean playerWins;                                                         // whether or not the player has shot all enemies before being killed
int health = 100;                                                           // current health of the player
int maxHealth = 100;                                                        // max health of the player

float[] shotX = new float[0];                                               // array to store the x positions of all shots fired
float[] shotY = new float[0];                                               // array to store the y positions of all shots fired
float[] shotXDir = new float[0];                                            // array to store the x directions of all shots fired
float[] shotYDir = new float[0];                                            // array to store the y directions of all shots fired
float[] shotXSpeed = new float[0];                                          // array to store the x speeds of all shots fired
float[] shotYSpeed = new float[0];                                          // array to store the y speeds of all shots fired
int shotDim = 10;                                                           // size of shots
float speedVal = 0;                                                         // initial speed of shots
float maxSpeed = 20;                                                        // max speed of shots

int enemyDim = 20;                                                          // size of enemies
float[] enemyX = {10, 10, 10, 10};                                          // initial x position of enemies
float[] enemyY = {10, 10, 10, 10};                                          // initial y position of enemies
boolean[] enemyAlive = {true, true, true, true};                            // whether or not specific enemies are alive
float[] enemyXDir = {1, 1, 1, 1};                                           // initial x direction of enemies
float[] enemyYDir = {1, 1, 1, 1};                                           // initial y direction of enemies
float[] enemyXSpeed = new float[enemyX.length];                             // declare and create array of enemy x speeds
float[] enemyYSpeed = new float[enemyX.length];                             // declare and create array of enemy y speeds

void setup() {
  size(600, 600);
  for (int i = 0; i < enemyX.length; i++) {                                 // assign random x and y speeds to enemies
    enemyXSpeed[i] = random(0.5, 7.5);
    enemyYSpeed[i] = random(0.5, 7.5);  
  }
}

void draw() {
  background(255);
  noStroke();
  if (playing) {                                                            // if the player is alive and there is at least one enemy alive
    drawEnemies();                                                          // draw enemies
    checkEnemyCollisions();                                                 // check if the player gets hit by any enemies
    drawShots();                                                            // draw shots that have been fired by the player
    checkShotCollisions();                                                  // check if any shots hit enemies
    if (checkEnemiesAllDead()) {                                            // if all enemies are dead...
      playing = false;                                                      // ...leave playing mode
      playerWins = true;                                                    // ...the player has won!
    }
    fill(0);
    ellipse(playerX, playerY, playerDim, playerDim);                        // draw the player
    stroke(0);
    strokeWeight(10);
    strokeCap(SQUARE);
    pushMatrix();
    translate(playerX, playerY);
    shootAngle = atan2(mouseY - playerY, mouseX - playerX);
    line(0, 0, shootRad * cos(shootAngle), shootRad * sin(shootAngle));     // draw the player's shooter barrel
    popMatrix();
    if (mousePressed) {                                                     // while the player is holding the mouse down, increase the shot speed
      speedVal = constrain(speedVal + .1, 0, maxSpeed);                     // keep speedVal less than maxSpeed
    }
    showProgressBar(50, 525, 200, 20, maxHealth, health, "Health meter");   // show health meter
    showProgressBar(50, 550, 200, 20, maxSpeed, speedVal, "Power meter");   // show power meter
  } else {
    if (playerWins) {                                                       // if the player has won...
      background(0, 255, 0);                                                // ...display a green background
    } else {                                                                // otherwise...
      background(255, 0, 0);                                                // ...display a red background
    }
    fill(255);
    textAlign(CENTER, CENTER);
    text("GAME OVER", 0, 0, width, height);                                 // display text
  }
}

void mouseReleased() {                                                      // every time the mouse button is released
  fireShot();                                                               // fire a shot
}

void drawEnemies() {                                                        // function to draw enemies that are alive
  for (int i = 0; i < enemyX.length; i++) {                                 // for all enemies
    if (enemyAlive[i]) {                                                    // if the enemy is alive
      fill(0);
      ellipse(enemyX[i], enemyY[i], enemyDim, enemyDim);                    // draw the enemy as an ellipse
      enemyX[i] += enemyXDir[i] * enemyXSpeed[i];                           // move the enemy horizontally
      if (enemyX[i] + enemyDim/2 > width || enemyX[i] - enemyDim/2 < 0) {   // if the enemy moves off the screen...
        enemyXDir[i] = -enemyXDir[i];                                       // ...move it back on
      }
      enemyY[i] += enemyYDir[i] * enemyYSpeed[i];                           // move the enemy vertically
      if (enemyY[i] + enemyDim/2 > width || enemyY[i] - enemyDim/2 < 0) {   // if the enemy moves off the screen...
        enemyYDir[i] = -enemyYDir[i];                                       // ...move it back on
      }
    }
  }
}

void checkEnemyCollisions() {                                               // function to check if any enemies hit the player
  for (int i = 0; i < enemyX.length; i++) {                                 // for all enemies
    if ((enemyX[i] + enemyDim/2 > playerX - playerDim/2) && (enemyX[i] - enemyDim/2 < playerX + playerDim/2) &&
        (enemyY[i] + enemyDim/2 > playerY - playerDim/2) && (enemyY[i] - enemyDim/2 < playerY + playerDim/2)) {      // if an enemy touches or overlaps the player
      health--;                                                             // decrease health
      if (health <= 0) {                                                    // if health reaches zero
        playing = false;                                                    // game over
      }
      println("Collision!");                                                // notify the player of a hit in the console
    }  
  }
}

void checkShotCollisions() {                                                // function to check if any shots hit enemies
  for (int i = 0; i < shotX.length; i++) {                                  // for all shots
    for (int j = 0; j < enemyX.length; j++) {                               // for all enemies
      if ((enemyX[j] + enemyDim/2 > shotX[i] - shotDim/2) && (enemyX[j] - enemyDim/2 < shotX[i] + shotDim/2) &&
          (enemyY[j] + enemyDim/2 > shotY[i] - shotDim/2) && (enemyY[j] - enemyDim/2 < shotY[i] + shotDim/2)) {      // if a shot touches or overlaps an enemy
        enemyAlive[j] = false;                                              // kill the enemy
      }
    }  
  }
}

boolean checkEnemiesAllDead() {                                             // function to check if all enemies are dead
  boolean allDead = true;                                                   // start off by assuming all enemies are dead
  for (int i = 0; i < enemyAlive.length; i++) {                             // for all enemies
    if (enemyAlive[i] == true) {                                            // if an enemy is alive...
      allDead = false;                                                      // ...our assumption was wrong
      break;                                                                // we don't need to continue checking the other enemies
    }
  }
  return allDead;  
}

void drawShots() {                                                          // function to draw shots fired
  noStroke();
  fill(255, 0, 0);
  if (shotX.length > 0) {                                                   // if at least one shot has been fired
    for (int i = 0; i < shotX.length; i++) {                                // for all shots fired
      ellipse(shotX[i], shotY[i], shotDim, shotDim);                        // draw an ellipse for the shot
      shotX[i] += shotXDir[i] * shotXSpeed[i];                              // move the shot horizontally
      shotY[i] += shotYDir[i] * shotYSpeed[i];                              // move the shot vertically
    }
  } 
}

void fireShot() {                                                           // function to fire shots
  shotX = append(shotX, playerX);                                           // add an initial x position for the new shot
  shotY = append(shotY, playerY);                                           // add an initial y position for the new shot
  if (mouseX >= playerX) {                                                  // determine the x direction for the new shot relative to the initial x position
    shotXDir = append(shotXDir, 1);
  } else {
    shotXDir = append(shotXDir, -1);
  }
  if (mouseY >= playerY) {                                                  // determine the y direction for the new shot relative to the initial y position
    shotYDir = append(shotYDir, 1);
  } else {
    shotYDir = append(shotYDir, -1);
  }
  shotXSpeed = append(shotXSpeed, abs(mouseX - playerX)/dist(mouseX, mouseY, playerX, playerY) * speedVal);      // determine the x speed for the new shot based on the x position of the mouse pointer
  shotYSpeed = append(shotYSpeed, abs(mouseY - playerY)/dist(mouseX, mouseY, playerX, playerY) * speedVal);      // determine the y speed for the new shot based on the y position of the mouse pointer
  speedVal = 0;                                                             // reset the speed of the shot, which is determined by the length of the mouse being pressed (see above in draw)
}

void showProgressBar(int x, int y, int w, int h, float max, float current, String label) {
  noStroke();
  fill(196);
  rect(x, y, w, h);
  fill(128);
  int progressVal = int(map(current, 0, max, 0, w));
  rect(x, y, progressVal, h);
  textAlign(LEFT, CENTER);
  text(label, x + w + 10, y, 100, h);
}
