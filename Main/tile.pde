import java.util.Random;
class Tile {
  color bodyColor;//creates the color variable, think of "color" as you would think of an "int"
  char letter;
  boolean placed;
  public int xpos;
  int ypos;

  public Tile() {
    placed = false;
    bodyColor = color(180, 102, 5);
    letter = (char)('A' + Math.random() * 26);
    Random rand = new Random();
    xpos = rand.nextInt(15) * 30;//top left vertex xpos, randomly scattered for now, still need to be acessed but we still don't have a nice permanenet place for them
    ypos = 16 * 30;//top left vertex ypos
  }

  public void print() {
    fill(bodyColor);//this means that all of the shapes that are made will be filled until noFill() is run
    System.out.println(xpos);
    rect(xpos,ypos,30,30);
    //testing
    //rect(90,90,30,30);//for now just a rectangle, tiles obviously have more variables
  }
  
  public int getxpos(){
    return xpos;
  }
  
  public int getypos(){
    return ypos;
  }
}