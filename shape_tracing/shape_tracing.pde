/*  
 shape_tracing
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

PGraphics drawCanvas;                                                       // graphics layer for the player's drawing
PGraphics drawShape;                                                        // invisible graphics layer for the target shape to be traced
boolean drawingMode = false;                                                // whether drawing mode is active or not (drawing only happens when the mouse is pressed)
int framesToPlay = 400;                                                     // number of frames to countdown (acts as an approximate timer)

void setup() {
  size(500, 500);
  frameRate(30);
  drawShape = createGraphics(width, height);                                // create an invisible graphics layer for the target shape to be traced
  drawShape.beginDraw();
  drawShape.background(255);
  drawShape.stroke(0);
  drawShape.strokeWeight(5);                                                // this weight relates to the weight of the tracing "brush" below: closer values = more challenging
  drawShape.ellipse(252, 250, 200, 200);                                    // draw the shape to be traced on this invisible layer
  drawShape.endDraw();
  drawCanvas = createGraphics(width, height);                               // create a graphics layer for drawing using the mouse
  drawCanvas.beginDraw();
  drawCanvas.background(0, 0);                                              // set the background to be transparent
  drawCanvas.endDraw();
  println("Try to trace the displayed shape before time runs out! A score of your accuracy will be displayed in the console when time is up.");
} 

void draw() {  
  background(128);
  if (drawingMode) {                                                        // if drawing mode is active (when the mouse is pressed)
    if (framesToPlay > 0) {                                                 // if the frame counter has not yet reached 0
      drawCanvas.beginDraw();
      drawCanvas.noStroke();
      drawCanvas.fill(255);                                                 // set the fill color to be white
      drawCanvas.ellipse(mouseX, mouseY, 15, 15);                           // draw on the drawCanvas layer using an ellipse as the "brush" (see above)
      drawCanvas.endDraw();
    }
  }  
  noFill();
  stroke(255);
  strokeWeight(1);
  ellipse(252, 250, 200, 200);                                              // draw the visible form to be traced as a guide, should be the same as the shape drawn on the invisible graphics layer (see above)
  if (framesToPlay > 0) {                                                   // if the frame counter has not yet reached 0
    framesToPlay--;                                                         // decrement the frame counter after every frame drawn
    text(str(framesToPlay), 10, 20);                                        // display the number of frames remaining
  }
  if (framesToPlay == 1) {                                                  // if the frame counter has reached 1
    println("Your score is: " + compare(drawShape, drawCanvas) + "%");      // compare the player's drawn shape and the shape to be traced and display a score
  }

  image(drawCanvas, 0, 0);                                                  // show the drawCanvas graphics layer
}

void mousePressed() {                                                       // when the mouse is pressed
  drawingMode = true;                                                       // start drawing mode
}

void mouseReleased() {                                                      // when the mouse is released
  drawingMode = false;                                                      // end drawing mode
}

void resetCanvas() {                                                        // this function clears the player's drawing (not currently used in this example)
  drawCanvas.beginDraw();
  drawCanvas.background(0, 0);
  drawCanvas.endDraw();
}

int compare(PGraphics original, PGraphics drawn) {                          // this function calculates a score based on the accuracy of the tracing
  original.loadPixels();                                                    // get the pixels of invisible layer with the shape to be traced
  drawn.loadPixels();                                                       // get the pixels of the player's drawing
  float originalNum = 0;                                                    // counter for the number of black pixels in the invisible layer with the shape to be traced
  float drawnNum = 0;                                                       // counter for the number of black pixels in the invisible layer after the white pixels from the player's drawing have been copied to the invisible layer
  for (int i = 0; i < original.pixels.length; i++) {
    if (brightness(original.pixels[i]) == 0) {                              // if a pixel in the invisible layer image is black
      originalNum++;                                                        // increment the originalNum counter
    }
    if (brightness(drawn.pixels[i]) == 255) {                               // if a pixel in the player's drawn image is white
      original.pixels[i] = drawn.pixels[i];                                 // copy that pixel to the invisible layer (this will overwrite a black pixel, if there is one, in the same location)
    }
  }
  original.updatePixels();                                                  // update the pixels in the invisible layer
  for (int i = 0; i < original.pixels.length; i++) {
    if (brightness(original.pixels[i]) == 0) {                              // if a pixel in the invisible layer image is black
      drawnNum++;                                                           // increment the drawnNum counter (this counts the black pixels in the invisible layer that were not covered by the white pixels of the player's drawing)
    }  
  }
  float difference = originalNum - drawnNum;
  int score = int((difference/originalNum) * 100);                          // calculate a percentage accuracy score
  return score;
}