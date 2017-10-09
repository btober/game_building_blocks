/*  
 block_sequence
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

String[] blockSequence = {"000", "000", "000", "000", "000", "000"};      // the initial block display; zeroes are blank
int randomBlock;                                                          // a random number indicating which block in the current row is black
int numCorrect;                                                           // the number of correct key presses the player has made
boolean playing = true;                                                   // whether the game is currently in progress or not

void setup() {
  size(300, 650);
  noStroke();
  addNewRow();                                                            // add the first randomly generated row
  println("Match the block sequence shown at the bottom of the window. Press j for the left block, k for the middle block, and l for the right block.");
}

void draw() {
  background(128);
  fill(255);
  textAlign(CENTER, CENTER);
  if (playing) {                                                          // if the game is currently in progress
  text("Number correct: " + numCorrect, 0, 0, width, 50);                 // display the number of correct key presses
  for (int i = 0; i < blockSequence.length; i++) {                        // for as many strings (rows) that there are in the blockSequence array
    for (int j = 0; j < 3; j++) {                                         // for each column of blocks
      if (str(blockSequence[i].charAt(j)).equals("0")) {                  // if this column's character in the string (row) is 0
        fill(128);                                                        // fill with gray
      } else if (str(blockSequence[i].charAt(j)).equals("1")) {           // if this column's character in the string (row) is 1
        fill(255);                                                        // fill with white
      } else {                                                            // otherwise
        fill(0);                                                          // fill with black
      }
      rect(j * 100, 50 + 100 * i, 100, 100);                              // draw the block
    }
  }
  } else {
    text("Game over!", 0, 0, width, height);
  }
}

void keyPressed() {                                                       // when a key is pressed
  if ((key == 'j' && randomBlock == 0) ||                                 // if the key is j and the first block in the current row is black
    (key == 'k' && randomBlock == 1) ||                                   // or if the key is k and the second block in the current row is black
    (key == 'l' && randomBlock == 2)) {                                   // or if the key is l and the third block in the current row is black
    addNewRow();                                                          // add a new row
    numCorrect++;                                                         // increase the numCorrect counter
  } else {                                                                // otherwise (with a wrong key press)
    playing = false;                                                      // game over
  }
}

void addNewRow() {                                                        // this function generates and adds a new row to blockSequence
  String newRow;                                                          // the string for the new row
  String[] reversed = reverse(blockSequence);                             // reverse the order of the elements in blockSequence
  String[] shortened = shorten(reversed);                                 // remove the last element in the reversed array
  String[] reversed2 = reverse(shortened);                                // re-reverse the shortened array
  randomBlock = int(random(0, 3));                                        // randomly choose the black block for the new row
  if (randomBlock == 0) {                                                 // if the first block will be black
    newRow = "211";
  } else if (randomBlock == 1) {                                          // if the second block will be black
    newRow = "121";
  } else {                                                                // if the third block will be black
    newRow = "112";
  }
  blockSequence = append(reversed2, newRow);                              // add the new row to the end of blockSequence
}