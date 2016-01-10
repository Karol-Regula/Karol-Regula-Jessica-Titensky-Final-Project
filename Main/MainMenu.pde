class MainMenu {
  public void setupMenu() {
    rect(75, 100, 300, 100);
  }

  public void detect() {
    if (mousePressed && mouseY < 200 && mouseY > 100 && mouseX > 75 && mouseY < 375) {//checks if mouse was pressed on the button
      mode = "gameScreen";//changes mode to the gameScreen
      GameScreen g1 = new GameScreen();//just creates gamescreen, the gamescreen class then takes over the setup
      g1.boardSetup();//runs only once, sets up board
    }
  }
}