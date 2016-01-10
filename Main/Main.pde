String mode;// literally determines what mode game is in

void setup() {
  //runs only at the beginning and does the initializing stuff
  size(450, 510);//window size
  background(255, 255, 0);//background color
  //noStroke();//disables border
  //fill(0, 102);//sets color used for filling
  mode = "mainMenu";//sets mode
  MainMenu m1 = new MainMenu();
  m1.setupMenu();//creates all the menus
}


void draw() {
  if (mode == "mainMenu") {// all the menu buttons would exist here
    MainMenu m1 = new MainMenu();//have to redo this after the setup for some reason
    m1.detect();//detects mouse presses and where the mouse it
  }
  if (mode == "gameScreen") {//would print the board and tiles and run the game code
  }
  if (mousePressed){//testing purposes
      System.out.println(mouseX + " " + mouseY);
  }
  //mouse pressed moved to MainMenu class
}