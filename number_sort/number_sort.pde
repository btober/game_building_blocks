/*  
 number_sort
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */
 
int[] values = {-1, 0, 1, 2, 3};                                                      // the "blocks" that will be sorted
int buttonD = 100;                                                                    // the width and height of each block
int blankIndex;                                                                       // the current index of the blank block (-1) in the values array
boolean sorted = false;                                                               // whether the shuffled blocks have been properly arranged by the player
int numMoves;                                                                         // the number of moves the player has made

void setup() {
  size(800, 200);
  shuffle(values);                                                                    // randomize the values array
  println("Clicking on a numbered block swaps it with the blank block. Sort the blocks numerically, starting with the blank block on the left, in as few moves as possible.");
}

void draw() {
  background(255);
  fill(0);
  for (int i = 0; i < values.length; i++) {
    fill(0);
    rect(50 + i * (buttonD + 50), 50, buttonD, buttonD);                              // draw a rectangle for each block
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(18);
    if (values[i] != -1) {                                                            // if the block isn't the blank block
      text(str(values[i]), 50 + i * (buttonD + 50), 50, buttonD, buttonD);            // draw the number label for each block
    }
  }
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(12);
  text("Number of moves: " + numMoves, 0, 0, width, 50);                              // display the number of moves the player has made
  if (sorted) {                                                                       // if the blocks have been properly arranged
    text("You win!", 0, 50 + buttonD, width, 50);                                     // display a message
  }
}

void mousePressed() {                                                                 // when the mouse is pressed
  for (int i = 0; i < values.length; i++) {                                           // check all of blocks
    if (!sorted) {                                                                    // if the blocks have not been sorted
      if (mouseX > 50 + i * (buttonD + 50) && mouseX < 50 + i * (buttonD + 50) + buttonD && mouseY > 50 && mouseY < 50 + buttonD) {      // if a block has been clicked on
        if (values[i] != -1) {                                                        // if the block clicked was not the blank block
          values[blankIndex] = values[i];                                             // switch the blank block with the block that was clicked on 
          values[i] = -1;
          blankIndex = i;
          numMoves++;                                                                 // the player has used another move
          sorted = checkSorted(values);                                               // check to see if the blocks have been arranged properly
        }
      }
    }
  }  
}

void shuffle(int[] array) {                                                           // from http://forum.processing.org/two/discussion/3546/how-to-randomize-order-of-array
  for (int i = array.length; i > 1; i--) {                                            // i is the number of items remaining to be shuffled
    int j = int(random(i));                                                           // Pick a random element to swap with the i-th element; 0 <= j <= i-1 (0-based array)
    int temp = array[j];                                                              // Swap array elements
    array[j] = array[i-1];
    array[i-1] = temp;
  }
  for (int i = 0; i < array.length; i++) {                                            // check all of the shuffled array items
    if (array[i] == -1) {                                                             // when -1 is found
      blankIndex = i;                                                                 // store the index in blankIndex
      break;                                                                          // end the loop
    }
  }
}

boolean checkSorted(int[] array) {                                                    // this function checks to see whether the blocks have been arranged properly
  int[] sortedArray = sort(array);                                                    // sort the array numerically (-1, 0, 1, 2, 3)
  for (int i = 0; i < array.length; i++) {                                            // check all of the original array items
    if (sortedArray[i] == array[i]) {                                                 // if the item at the index in both sorted and original arrays is equal
      continue;                                                                       // continue checking
    } else {
      return false;                                                                   // otherwise the blocks have not been arranged properly
    }
  }
  return true;                                                                        // the blocks have been arranged properly
}
