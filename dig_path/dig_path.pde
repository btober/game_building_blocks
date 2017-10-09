/*  
 dig_path
 Game Building Blocks for Processing
 (c) 2013–2017 Brad Tober [http://www.bradtober.com]
 Licensed under The MIT License
 */

PGraphics tempTrail;                                                                        // an invisible graphics layer
PGraphics trail;                                                                            // a graphics layer to display the dig path
int cursorDim = 100;                                                                        // width and height of dig cursor
int cursorX = 200;                                                                          // initial x position of dig cursor
int cursorY = 200;                                                                          // initial y position of dig cursor
int cursorInc = 20;                                                                         // number of pixels to move the cursor every time a key is pressed

void setup() {
  size(500, 500);
  noStroke();
  tempTrail = createGraphics(width, 300);
  trail = createGraphics(width, 300);
  trail.beginDraw();
  trail.noStroke();
  trail.fill(128);
  trail.endDraw();
  println("Use the left, right, and down arrows to dig a path.");
}

void draw() {
  background(255);
  trail.beginDraw();
  trail.rect(cursorX, cursorY, cursorDim, cursorDim);                                       // draw the dig path on the trail graphics layer
  trail.endDraw();
  image(trail, 0, 0);                                                                       // display the trail graphics layer
  fill(0);
  rect(cursorX, cursorY, cursorDim, cursorDim);                                             // draw the dig cursor
}

void keyPressed() {                                                                         // when a key is pressed
  if (key == CODED) {
    if (keyCode == DOWN) {                                                                  // if the down arrow is pressed
      copyPG(trail, tempTrail, 0);                                                          // copy the trail layer to the invisible tempTrail layer
      clearPG(trail);                                                                       // clear the trail layer
      copyPG(tempTrail, trail, cursorInc);                                                  // copy the tempTrail layer back to the trail layer, shifted upwards by cursorInc
      clearPG(tempTrail);                                                                   // clear the tempTrail layer
    }
    if (keyCode == LEFT) {                                                                  // if the left arrow is pressed
      cursorX -= cursorInc;                                                                 // move the cursor to the left
      if (cursorX < 0) {                                                                    // if the cursor moved off the left side of the window...
        cursorX += cursorInc;                                                               // ...move it back to the right
      } 
    }
    if (keyCode == RIGHT) {                                                                 // if the right arrow is pressed
      cursorX += cursorInc;                                                                 // move the cursor to the right
      if (cursorX + cursorDim > width) {                                                    // if the cursor moved off the right side of the window...
        cursorX -= cursorInc;                                                               // ...move it back to the left
      } 
    }  
  }
}

void clearPG(PGraphics graphics) { // we need this function for ProcessingJS compatibility, as PJS doesn't have clear()
  graphics.loadPixels();
  for (int i = 0; i < graphics.width * graphics.height; i++) {
    graphics.pixels[i] = 0;
  }
  graphics.updatePixels();
}

void copyPG(PGraphics source, PGraphics dest, int offset) { // we need this function for ProcessingJS compatibility, as copy() is messed up in PJS
  source.loadPixels();
  dest.beginDraw();
  dest.loadPixels();
  for (int i = 0; i < (source.width * source.height) - (source.width * offset); i++) {
    dest.pixels[i] = source.pixels[(offset * source.width) + i];
  }
  dest.updatePixels();
  dest.endDraw();
}