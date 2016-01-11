String mode;// literally determines what mode game is in

GameScreen g1 = new GameScreen();//made these into global(ish) variables so that they do not have to re-initialized in every method that uses their methods
MainMenu m1 = new MainMenu();

void setup() {
  frameRate(60);
  //runs only at the beginning and does the initializing stuff
  size(510, 510);//window size
  background(255, 255, 0);//background color
  //noStroke();//disables border
  //fill(0, 102);//sets color used for filling
  mode = "mainMenu";//sets mode
  MainMenu m1 = new MainMenu();
  m1.setupMenu();//creates all the menus
}

void mouseClicked() {
  g1.mouseClicked();
}

void draw() {
  if (mode == "mainMenu") {// all the menu buttons would exist here
    m1.detect();//detects mouse presses and where the mouse it
  }
  if (mode == "gameScreen") {//would print the board and tiles and run the game code
    //g1.detect();
    //g1.mouseClicked();
  }
  if (mousePressed) {//testing purposes
    // System.out.println(mouseX + " " + mouseY); prints mouse position into console
  }
  //mouse pressed moved to MainMenu class
}

//make boards and stuff into gloabl variables to avoid making new ones
//clicking and dragging, redraw board and tiles
//work out percentages for tiles
//news gothic standard font
//if time, computer predicts moves of player and adjusts accordinglly
//overhaul coordinate system
//read rules