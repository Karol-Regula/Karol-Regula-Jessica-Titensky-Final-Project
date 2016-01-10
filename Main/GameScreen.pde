class GameScreen {
  ArrayList<Tile> tileDescription = new ArrayList<Tile>(1);//tiles stored in Arraylist contaning object arrays which in turn store data about tiles 
  //methods that need to run while game is in gamemode

  public void boardSetup() {
    Board b1 = new Board();
    b1.ddraw();
    for (int x = 0; x < 30; x ++) {
      Tile t1 = new Tile();
      tileDescription.add(t1);//adds new tile into Arraylist
      t1.print();//not updated to print everything
    }
         System.out.println(tileDescription.get(3).xpos);
  }
}