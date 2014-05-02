/*  
 matching
 Game Building Blocks for Processing
 (c) 2014 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

int rows = 4;                                                                                      // number of rows
int cols = 5;                                                                                      // number of cols
int hInterval;                                                                                     // column width
int vInterval;                                                                                     // row height
int shapeDim = 50;                                                                                 // object size

boolean[][] showItem;                                                                              // keeps track of whether an item is shown or not
boolean showAll;                                                                                   // whether all items are shown or not (for use with help)
int showTimer;                                                                                     // a timer for the help function
int helpCount;                                                                                     // how many times help has been used
boolean[][] removed;                                                                               // whether a matched pair has been made
int[] matches;                                                                                     // array of paired numbers
int[][] matchID;                                                                                   // shuffled paired numbers assigned to item array

int lastI = -1;                                                                                    // keeps track of last item clicked
int lastJ = -1;

void setup() {
  size(500, 400);
  smooth();
  noStroke();
  hInterval = width/cols;                                                                         // calculate column width
  vInterval = height/rows;                                                                        // calculate row height
  showItem = new boolean[rows][cols];
  removed = new boolean[rows][cols];
  matches = new int[rows * cols];
  for (int i = 0; i < matches.length/2; i++) {                                                    // assign paired numbers to matches array
    matches[i] = i;
    matches[i + matches.length/2] = i;    
  }
  matches = shuffle(matches);                                                                     // randomize matches array, see shuffle() below
  matchID = new int[rows][cols];
  for (int i = 0; i < rows; i++) {                                                                // assign randomized matches array to item array
    for (int j = 0; j < cols; j++) {
      matchID[i][j] = matches[(i*cols) + j];
    }
  }
  println("Find the matching items! Press the 'h' key for a quick peek at them all, up to 3 times.");
}

void draw() {
  background(255);
  for (int i = 0; i < rows; i++) {                                                                // for all rows
    for (int j = 0; j < cols; j++) {                                                              // for all columns
      if (!(removed[i][j])) {                                                                     // if an item hasn't been removed (matched as part of a pair)...
        if (showItem[i][j] || showAll) {                                                          // if the item is being shown (has been clicked on) or the help feature is activated...
          fill(255);
          stroke(0);
          ellipse((j * 100) + hInterval/2, (i * 100) + vInterval/2, shapeDim, shapeDim);          // ...draw an ellipse with stroke
          fill(0);
          textAlign(CENTER, CENTER);
          text(str(matchID[i][j]), ((j * 100) + hInterval/2) - shapeDim/2, ((i * 100) + vInterval/2) - shapeDim/2, shapeDim, shapeDim);      // ...draw text that displays the match number
          noStroke();
        } 
        else {
          fill(0);
          ellipse((j * 100) + hInterval/2, (i * 100) + vInterval/2, shapeDim, shapeDim);          // ...draw a solid ellipse
        }
      }
    }
  }
  if (millis() - showTimer > 1000) {                                                              // if the help timer has passed 1 second...
    showAll = false;                                                                              // ...hide everything again
  }
}

void mousePressed() {
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (mouseX > ((j * 100) + hInterval/2) - shapeDim/2
       && mouseX < ((j * 100) + hInterval/2) + shapeDim/2
       && mouseY > ((i * 100) + vInterval/2) - shapeDim/2
       && mouseY < ((i * 100) + vInterval/2) + shapeDim/2) {                                      // if the player clicks on an item...
        if (showItem[i][j]) {                                                                     // if the item is shown...
          showItem[i][j] = false;                                                                 // ...hide it
          lastI = -1;
          lastJ = -1;
        } else {                                                                                  // otherwise (if the item is hidden)...
          if (lastI == -1 && lastJ == -1) {                                                       // if the item is the first of a prospective pair to be clicked...
            showItem[i][j] = true;                                                                // ...show the item
            lastI = i;                                                                            // ...identify it as the last item clicked
            lastJ = j;
          } else if (matchID[lastI][lastJ] == matchID[i][j] && !(lastI == i && lastJ == j)) {     // if the item clicked is not the previous one clicked and it matches the previous one clicked...
            removed[i][j] = true;                                                                 // ...remove the item clicked
            removed[lastI][lastJ] = true;                                                         // ...remove the previous item clicked
            lastI = -1;                                                                           // ...reset the previous item clicked
            lastJ = -1; 
          } else {                                                                                // otherwise (if not a match to the previous item clicked)...
            showItem[i][j] = false;                                                               // ...hide the item clicked
            showItem[lastI][lastJ] = false;                                                       // ...hide the previous item clicked
            lastI = -1;                                                                           // ...reset the previous item clicked
            lastJ = -1; 
          }
        }
      }
    }
  }
  winCheck(removed);                                                                              // check if the player has made all matches and won
}

void keyPressed() {
  if (key == 'h' && helpCount < 3) {                                                              // when the player presses the 'h' key and hasn't yet used help 3 times...
    showAll = true;                                                                               // ...show all items
    showTimer = millis();                                                                         // ...start the timer that determines how long they wil be visible
    helpCount++;                                                                                  // ...increase the number of times help has been used
  }  
}

int[] shuffle(int[] toShuffle) {                                                                  // from http://processing.org/discourse/beta/num_1194572947.html
  int[] shuffled = new int[toShuffle.length];
  int i = 0;
  while (toShuffle.length > 0) {
    int rnd = int(random(toShuffle.length));
    shuffled[i] = toShuffle[rnd];
    i++;
    if (rnd > 0 && rnd < toShuffle.length-1) {
      toShuffle = concat(subset(toShuffle, 0, rnd), subset(toShuffle, rnd+1, toShuffle.length-rnd-1));
    } else if (rnd == 0) {
      toShuffle = subset(toShuffle, 1, toShuffle.length-1);
    } else {
      toShuffle = shorten(toShuffle);
    }  
  }
  return shuffled;
}

boolean winCheck(boolean[][] removed) {                                                           // this function returns whether the player has won or not by checking whether all pair matches have been made
  for (int i = 0; i < rows; i++) {
    for (int j = 0; j < cols; j++) {
      if (removed[i][j] == false) {
        return false;  
      }
    }
  }
  println("You win!");  
  return true;
}
