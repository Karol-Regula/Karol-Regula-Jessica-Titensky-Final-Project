class GameScreen {
  //methods that need to run while game is in gamemode

  public void boardSetup() {
    Board b1 = new Board();
    b1.ddraw();
    for (int x = 0; x < 100; x ++) {
      Tile t1 = new Tile();
      t1.print();
    }
  }
}