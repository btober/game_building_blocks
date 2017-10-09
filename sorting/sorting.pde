/*  
 sorting
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

int itemX, itemY;                                                  // x and y positions of the item to be sorted
int itemDim = 40;                                                  // size of the item to be sorted
int itemType;                                                      // a number that specifies which bin the current item should be placed in
int xInc = 10;                                                     // number of pixels to move the item horizontally using the arrow keys
int yInc = 2;                                                      // number of pixels to move the item vertically each frame
int numCorrect, numIncorrect;                                      // numbers of items sorted correctly and incorrectly
 
void setup() {
  size(600, 600);
  noStroke();
  textAlign(CENTER, CENTER);
  itemX = width/2;                                                 // set the initial x position of the item to be in the middle of the window
  itemY = 50;                                                      // set the initial y position of the item
  itemType = int(random(1, 4));                                    // determine the initial type of the item
}

void draw() {
  background(255);
  drawIndicators();                                                // run the code inside of the drawIndicators() function
  drawItem();                                                      // run the code inside of the drawItem() function
  drawBins();                                                      // run the code inside of the drawBins() function
  drawScores();                                                    // run the code inside of the drawScores() function
  itemY += yInc;                                                   // move the item down
  if (itemY - itemDim/2 > 500) {                                   // if the item is in one of the three bins...
    if (itemX > 0 && itemX <= 200 && itemType == 1) {              // if the item is in bin 1 and the item is type 1...
      numCorrect++;                                                // ...increase the correct score
    } else if (itemX > 200 && itemX <= 400 && itemType == 2) {     // if the item is in bin 2 and the item is type 2...
      numCorrect++;                                                // ...increase the correct score
    } else if (itemX > 400 && itemX <= width && itemType == 3) {   // if the item is in bin 3 and the item is type 3...
      numCorrect++;                                                // ...increase the correct score
    } else {                                                       // otherwise...
      numIncorrect++;                                              // ...increase the incorrect score
    }
    itemX = width/2;                                               // reset the x position of the new item to be in the middle of the window
    itemY = 50;                                                    // reset the y position of the new item
    itemType = int(random(1, 4));                                  // determine the type of the new item
  }  
}

void drawIndicators() {
  if (itemX > 0 && itemX <= 200) {                                 // if the item is in the left third of the window...
    fill(255, 0, 0, 32);
    rect(0, 0, 200, 600);                                          // draw a light red rectangle
  }  
  if (itemX > 200 && itemX <= 400) {                               // if the item is in the middle third of the window...
    fill(0, 255, 0, 32);
    rect(200, 0, 200, 600);                                        // draw a light green rectangle
  }
  if (itemX > 400 && itemX <= width) {                             // if the item is in the right third of the window...
    fill(0, 0, 255, 32);
    rect(400, 0, 200, 600);                                        // draw a light blue rectangle
  }    
}

void drawItem() {
  fill(0, 128);
  ellipse(itemX, itemY, itemDim, itemDim);                         // draw an ellipse for the item
  fill(255);
  text(str(itemType), itemX-itemDim/2, itemY - itemDim/2, itemDim, itemDim);    // draw text to identify the item type
}

void drawBins() {
  fill(255, 0, 0);
  rect(0, 500, 200, 100);                                          // draw a rectangle for bin 1
  fill(0, 255, 0);
  rect(200, 500, 200, 100);                                        // draw a rectangle for bin 2
  fill(0, 0, 255);
  rect(400, 500, 200, 100);                                        // draw a rectangle for bin 3
  fill(255);
  text("1", 0, 500, 200, 100);                                     // draw a text label for bin 1
  text("2", 200, 500, 200, 100);                                   // draw a text label for bin 2
  text("3", 400, 500, 200, 100);                                   // draw a text label for bin 3
}

void drawScores() {
  fill(192);
  rect(0, 0, width, 20);
  fill(0);
  text("Correct: " + numCorrect + "   Incorrect: " + numIncorrect, 0, 0, width, 20);    // draw text to display scores
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == LEFT) {                                         // if the left arrow is pressed...
      itemX -= xInc;                                               // ...move the item to the left
      if (itemX - itemDim/2 < 0) {                                 // if the item moves off the left side of the window...
        itemX += xInc;                                             // ...move it back to the previous position  
      }
    }
    if (keyCode == RIGHT) {                                        // if the right arrow is pressed...
      itemX += xInc;                                               // ...move the item to the right
      if (itemX + itemDim/2 > width) {                             // if the item moves off the right side of the window...
        itemX -= xInc;                                             // ...move it back to the previous position    
      }
    }   
  }  
}