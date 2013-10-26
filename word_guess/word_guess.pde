/*  
 word_guess
 Game Building Blocks for Processing
 (c) 2013 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

String[] words;                                                               // String array for all of the words in the word list file
char[] shownLetters;                                                          // array of the characters in the chosen word that have already been revealed
boolean incorrect = false;                                                    // whether a key press was the next letter in the chosen word or not
boolean endGame = false;                                                      // whether the game is over or not
int startTime;                                                                // timer for displaying incorrect message
int dispTime = 1000;                                                          // amount of time, in milliseconds, to show incorrect message
int chosenWord;                                                               // index of chosen word in String array
int wordLength;                                                               // length of chosen word
int currentChar = 1;                                                          // the index of the character the player will be trying to identify at any given time (starts at 1 because the first letter, with index 0, will be shown automatically)
int letterSpaceWidth = 50;                                                    // width of space for each letter

void setup() {
  size(1000, 125);
  smooth();
  words = loadStrings("word_list.txt");                                       // get the words from the word list
  println("The first letter of a word is shown. Try to guess what it is by typing the subsequent letters!");
  chosenWord = int(random(0, words.length - .01));                            // get a random number that corresponds to a word from the list
  println(words[chosenWord]);
  wordLength = words[chosenWord].length();                                    // find out how long the chosen word is
  shownLetters = new char[wordLength];                                        // initialize shownLetters as a char array for all of the letters in the selected word
  shownLetters[0] = words[chosenWord].charAt(0);                              // assign the first letter of the word to the first index in the array
}

void draw() {
  background(255);
  fill(0);
  for (int i = 0; i < wordLength; i++) {
    int xPos = ((i * letterSpaceWidth) + ((i + 1) * 10));                     // calculate a position for each letter in the word
    line(xPos, 50, xPos + letterSpaceWidth, 50);                              // draw a line for each letter in the word
    textSize(25);
    textAlign(CENTER);
    if (shownLetters[i] != '\u0000') {                                        // if a letter has already been identified
      text(str(shownLetters[i]), xPos, 15, letterSpaceWidth, 50);             // show that letter
    }
  }
  textAlign(LEFT);
  if (incorrect) {                                                            // if the last key pressed was incorrect
    text("Incorrect!", 28, 98);                                               // display a message
    if ((millis() - startTime) > dispTime) {                                  // after the timer ends
      incorrect = false;                                                      // don't show the message any longer
    }
  }
  if (endGame) { 
    text("You won!", 28, 98);                                                 // game over
  }
}

void keyPressed() {     
  incorrect = false;                                                          // reset the incorrect message
  if (currentChar < words[chosenWord].length()) {                             // if the current letter is before the end of the word
    if (str(key).equals(str(words[chosenWord].charAt(currentChar)))) {                       // if the key pressed is the next letter in the word
      shownLetters[currentChar] = words[chosenWord].charAt(currentChar);      // add that letter to the list of identified letters
      if (currentChar == words[chosenWord].length() - 1) {                    // if the current letter is the last letter in the word
        endGame = true;                                                       // game over
      } 
      currentChar++;                                                          // move on to the next letter
    } 
    else {
      incorrect = true;                                                       // otherwise the key pressed was wrong
      startTime = millis();                                                   // start the timer for displaying the incorrect message
    }
  }
}
