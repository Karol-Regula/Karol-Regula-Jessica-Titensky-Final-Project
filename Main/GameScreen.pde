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
    //System.out.println(tileDescription.get(3).xpos + " " + tileDescription.get(3).ypos);
  }

  public void detect() {
    if (mousePressed) {//will check if mouse was pressed on a tile, tile will follow mouse
      for (int x = 0; x < tileDescription.size(); x++) {
        if (mouseX > tileDescription.get(x).xpos && mouseX < tileDescription.get(x).xpos + 30 &&
          mouseY > tileDescription.get(x).ypos && mouseY < tileDescription.get(x).ypos + 30) {
          System.out.println("got here");
          /*
          ===========================//this commented code is supposed to make the tile follow the mouse, it does not fully work as of now, mouse detection still works
          while (! mousePressed) {//follows until next mouse press
            System.out.println("and here");
            Tile tc = tileDescription.get(x);
            tc.xpos = mouseX;
            tc.ypos = mouseY;
            tc.print();
            */
          }
        }
      }
    }
  }
}