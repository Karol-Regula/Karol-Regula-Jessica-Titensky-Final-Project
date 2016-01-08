String mode;// literally determines what mode game is in

void setup() {
  //runs only at the beginning and does the initializing stuff
  size(450,450);//window size
  background(255,255,0);//background color
  //noStroke();//disables border
  //fill(0, 102);//sets color used for filling
  mode = "mainMenu";//sets mode
  
  
}


void draw() {
    if (mode == "mainMenu") {// all the menu buttons would exist here
      rect(100, 150, 200, 250);
  }
  if (mode == "gameScreen"){//would print the board and tiles and run the game code

  }
  if (mousePressed){//assume this is what mainmenu exits to
      mode = "gameScreen";//changes mode to the gameScreen
      GameScreen g1 = new GameScreen();//just creates gamescreen, the gamescreen class then takes over the setup
      g1.boardSetup();//runs only once, sets up board
  }
}