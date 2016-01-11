class GameScreen {

  boolean selected=false;

  ArrayList<Tile> tileDescription = new ArrayList<Tile>(1);//tiles stored in Arraylist contaning object arrays which in turn store data about tiles 
  //methods that need to run while game is in gamemode

  public void boardSetup() {
    Board b1 = new Board();
    b1.ddraw();
    for (int x = 0; x < 15; x ++) {
      Tile t1 = new Tile(x);
      tileDescription.add(t1);//adds new tile into Arraylist
      t1.print();//not updated to print everything
    }
    //System.out.println(tileDescription.get(3).xpos + " " + tileDescription.get(3).ypos);
  }

  public boolean detect() {
    Tile t=tileDescription.get(0);
    //if (mousePressed) {//will check if mouse was pressed on a tile, tile will follow mouse
    for (int x = 0; x < tileDescription.size(); x++) {
      if (mouseX > tileDescription.get(x).xpos && mouseX < tileDescription.get(x).xpos + 30 &&
        mouseY > tileDescription.get(x).ypos && mouseY < tileDescription.get(x).ypos + 30) {
        if (mouseY>480) {
          System.out.println("got here");
          t=tileDescription.get(x);
          t.bodyColor=color(204, 159, 102);
          fill(t.bodyColor);
          rect(t.xpos, t.ypos, 30, 30);
          return true;
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
    //}
    return false;
  }

  public void move() {
    Tile t=tileDescription.get(0);
    for (int i=0; i<tileDescription.size(); i++) {
      if (tileDescription.get(i).bodyColor==color(204, 159, 102)) {
        t=tileDescription.get(i);
      }
    }
    System.out.println("pressed");
    fill(255, 255, 255);
    rect(t.xpos, t.ypos, 30, 30);
    selected=false;
    t.xpos=mouseX-mouseX%30;
    t.ypos=mouseY-mouseY%30;
    t.bodyColor = color(180, 102, 5);
    t.print();
  }

  public void mouseClicked() {
    if (480<mouseX && 510>mouseX && 450<mouseY && 480>mouseY) {
      Board b1=new Board();
      b1.ddraw();
      for (int i=0; i<tileDescription.size(); i++) {
        fill(180, 102, 5);
        rect(tileDescription.get(i).origx, tileDescription.get(i).origy, 30, 30);
        tileDescription.get(i).xpos=tileDescription.get(i).origx;
        tileDescription.get(i).ypos=tileDescription.get(i).origy;
      }
    } 
    if (480<mouseX && 510>mouseX && 480<mouseY && 510>mouseY) {
      System.out.println("MUAHAHA");
      for (int i=0; i<tileDescription.size(); i++) {
        Tile t =tileDescription.get(i);
        if (t.origy!=t.ypos) {
          t.placed=true;
        }
        t.origx=t.xpos;
        t.origy=t.ypos;
      }
    }
    if (selected) {
      move();
    } else {
      selected=detect();
    }
  }
}