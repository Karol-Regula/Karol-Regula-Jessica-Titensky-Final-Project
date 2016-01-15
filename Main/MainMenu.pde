class MainMenu {
  public void setupMenu() {
    rect(75+xd, 100+yd, 300, 100);
  }

  public void detect() {
    if (mousePressed && mouseY - yd < 200 && mouseY - yd > 100 && mouseX - xd > 75 && mouseY - yd < 375) {//checks if mouse was pressed on the button
      mode = "gameScreen";//changes mode to the gameScreen
      g1.boardSetup();//runs only once, sets up board
    }
  }
}