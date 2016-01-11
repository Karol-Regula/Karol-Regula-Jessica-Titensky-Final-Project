import java.util.Random;
class Tile {
  public color bodyColor;//creates the color variable, think of "color" as you would think of an "int"
  public char letter;
  public boolean placed;
  public int xpos;
  public int ypos;
  public int origx;
  public int origy;

  public Tile(int xplace) {
    placed = false;
    bodyColor = color(180, 102, 5);
    letter = (char)('A' + Math.random() * 26);
    Random rand = new Random();
    origx= xpos = xplace * 30;//top left vertex xpos, randomly scattered for now, still need to be acessed but we still don't have a nice permanenet place for them
    origy= ypos = 480;//top left vertex ypos
  }

  public void print() {
    fill(bodyColor);//this means that all of the shapes that are made will be filled until noFill() is run
    System.out.println(xpos+" "+ypos);
    rect(xpos, ypos, 30, 30);
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