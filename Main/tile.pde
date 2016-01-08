class Tile{
    color bodyColor;//creates the color variable, think of "color" as you would think of an "int"
    
    public Tile(){
        bodyColor = color(0, 55, 255);
    }
  
   public void print(){
     fill(bodyColor);//this means that all of the shapes that are made will be filled until noFill() is run
     rect(100, 150, 200, 200);//for now just a rectangle, tiles obviously have more variables
   }
 }