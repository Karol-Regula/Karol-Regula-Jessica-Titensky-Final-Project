import java.util.Random;
class Tile {
  color bodyColor;//creates the color variable, think of "color" as you would think of an "int"
  char letter;
  boolean placed;
  int xpos;
  int ypos;

  public Tile() {
    placed = false;
    bodyColor = color(0, 55, 255);
    letter = (char)('A' + Math.random() * 26);
    xpos = 0;
    ypos = 0;
  }

  public void print() {
    fill(bodyColor);//this means that all of the shapes that are made will be filled until noFill() is run
    //testing
    Random rand = new Random();
    rect(rand.nextInt(15) * 30, 16 * 30, 30, 30);
    //rect(90,90,30,30);//for now just a rectangle, tiles obviously have more variables
  }
}