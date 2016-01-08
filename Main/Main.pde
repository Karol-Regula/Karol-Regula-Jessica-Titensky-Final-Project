String mode;// literally determines what mode game is in

void setup() {
  //runs only at the beginning and does the initializing stuff
  size(640, 480);//window size
  background(255,255,0);//background color
  //noStroke();//disables border
  //fill(0, 102);//sets color used for filling
  mode = "mainMenu";//sets mode
}


void draw() {
  tile t1 = new tile();//creates new "tile", super basic for now (see tile tab)
  background(255,255,0);//redraws the background to cover up stuff that is no longer drawn after mode change
  if (mode == "mainMenu") {// all the menu buttons would exist here
      rect(100, 150, 200, 250);
  }
  if (mode == "gameScreen"){//would print the board and tiles and run the game code
      ellipse(100, 100, 200, 200);
  }
  if (mousePressed){//detecting mousepresses, I made this ony to check if we can change the mode, a menu variable should change this in the future
      mode = "gameScreen";//changes mode to the gameScreen
      t1.print();//runs the print method in the tile class
  }
}