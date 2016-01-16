import java.util.Random;
class Tile {
  public color bodyColor;//creates the color variable, think of "color" as you would think of an "int"
  public char letter;
  public int score;
  public boolean placed;
  public int inTray;
  public int xpos;
  public int ypos;
  public int origx;
  public int origy;
  public String owner;

  public Tile(char whatLetter, int whatScore) {//have to rework xplace, might be redundant
    placed = false;
    bodyColor = color(180, 102, 5);
    letter = whatLetter;
    score = whatScore;
    xpos = 10000;
    ypos = 10000;//offsceen so that the method that reverts a placed tile does not print all unused tiles in top left corner.
    origx= 10000;//top left vertex xpos, randomly scattered for now, still need to be acessed but we still don't have a nice permanenet place for them
    origy= 10000;//top left vertex ypos
  }

  public void print(color whatColor) {
    PFont f = createFont("Arial", 16, true);
    bodyColor = whatColor;
    fill(bodyColor);  
    rect(xpos+xd, ypos+yd, size, size);
    textFont(f, 25);
    fill(0, 0, 0);//this means that all of the shapes that are made will be filled until noFill() is run
    text(letter, xpos + (size/2) -size/5+xd, ypos + (size/2) +size/5+yd);//has some manual adjustments made for now //===================================need to manually adjust
    textFont(f, 10);
    text(score, xpos + (size/2) + 12+xd, ypos + (size/2) + 15+yd);
    
    //for debugging, >>>also see code in nextPlayer()<<<;
    text(xpos, xpos + (size/2) + 12+xd -20, ypos + (size/2) + 15+yd - 60);
    text(ypos, xpos + (size/2) + 12+xd -20, ypos + (size/2) + 15+yd - 50);
    text(origx, xpos + (size/2) + 12+xd -20, ypos + (size/2) + 15+yd - 40);
    text(origy, xpos + (size/2) + 12+xd -20, ypos + (size/2) + 15+yd - 30);
    
    
    //testing
    //rect(90,90,30,30);//for now just a rectangle, tiles obviously have more variables
  }
  
  public int getxpos() {
    return xpos;
  }

  public int getypos() {
    return ypos;
  }
}