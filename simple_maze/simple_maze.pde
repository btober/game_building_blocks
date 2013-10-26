/*  
 simple_maze
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 
 Get a new maze image at http://www.mazegenerator.net/ or use custom mazes with rgb(0, 0, 0) boundaries
 */

PImage mazeImg;                                                  // maze image
int xPos = 66;                                                   // starting x position of cursor (depends on maze layout)
int yPos = 2;                                                    // starting y position of cursor (depends on maze layout)
int incVal = 4;                                                  // the number of pixels the cursor moves with every arrow press (this depends partially on maze dimensions and cursor size)
float radius = 6.5;                                              // radius of cursor
boolean mazeOver = false;                                        // whether the destination point of the maze has been reached or not

void setup() {
  size(162, 162);
  smooth();
  noStroke();
  mazeImg = loadImage("maze.png");
}


void draw() {
  image(mazeImg, 0, 0);
  fill(255, 0, 0);
  ellipse(xPos + radius, yPos + radius, radius * 2, radius * 2); // draw maze cursor
}

void keyPressed() {                                              // when a key is pressed
  if (mazeOver == false) {                                       // if the destination point of the maze has not been reached
    if ((key == CODED) && (keyCode == UP)) {                     // if the up arrow was pressed
      yPos -= incVal;                                            // decrease the y position of the cursor by incVal (move cursor up)
      if (mazeTest() == false) {                                 // if mazeTest() shows that this new position would cross a boundary
        yPos += incVal;                                          // move the cursor back to the previous position                      
      }
    }
    if ((key == CODED) && (keyCode == DOWN)) {                   // if the down arrow was pressed
      yPos += incVal;                                            // increase the y position of the cursor by incVal (move cursor down)
      if (mazeTest() == false) {                                 // if mazeTest() shows that this new position would cross a boundary
        yPos -= incVal;                                          // move the cursor back to the previous position
      }
    }
    if ((key == CODED) && (keyCode == LEFT)) {                   // if the left arrow was pressed
      xPos -= incVal;                                            // decrease the x position of the cursor by incVal (move cursor left)
      if (mazeTest() == false) {                                 // if mazeTest() shows that this new position would cross a boundary
        xPos += incVal;                                          // move the cursor back to the previous position
      }
    }
    if ((key == CODED) && (keyCode == RIGHT)) {                  // if the right arrow was pressed
      xPos += incVal;                                            // increase the x position of the cursor by incVal (move cursor right)
      if (mazeTest() == false) {                                 // if mazeTest() shows that this new position would cross a boundary
        xPos -= incVal;                                          // move the cursor back to the previous position
      }
    }
    if (xPos < 2) {
      xPos = 2;                                                  // don't let the cursor move off the left side of the window
    }
    if (xPos > 146) {
      xPos = 146;                                                // don't let the cursor move off the right side of the window
    } 
    if (yPos < 2) {
      yPos = 2;                                                  // don't let the cursor move off the top side of the window
    }
    if (yPos > 146) {
      yPos = 146;                                                // don't let the cursor move off the bottom side of the window
    }
    if ((xPos == 82) && (yPos == 146)) {                         // if the cursor is in the final position
      println("You win!");
      mazeOver = true;                                           // the player wins
    }
  }
}

boolean mazeTest() {                                             // this function checks whether the cursor is going to cross a maze boundary or not when the cursor is moving
  int counter = 0;
  for (int i = xPos; i <= (xPos + radius * 2); i++) {
    for (int j = yPos; j <= (yPos + radius * 2); j++) {
      int mazeVal = int(brightness(mazeImg.get(i, j)));          // get the brightness of each pixel in the maze image covered by the cursor
      if (mazeVal == 0) {                                        // if a pixel is black (meaning the cursor is crossing a boundary)
        counter++;                                               // increment counter
      }
    }
  }
  if (counter > 0) {                                             // if counter is greater than zero, meaning there are some boundary pixels the cursor is crossing
    return false;                                                // mazeTest fails
  } 
  else {
    return true;                                                 // otherwise mazeTest passes
  }
}
