public class AI extends GameScreen{
  int level;
  
  public AI(){
    level = 0;
  }
  
  public ArrayList<Tile> grabTiles(){//produces an ArrayList of tiles that the AI has that particular turn
    ArrayList<Tile> hasNow = new ArrayList<Tile>();
    for (int i = 0; i < g1.tileDescription.size(); i ++){
      if (g1.tileDescription.get(i).owner == g1.activePlayer().name && g1.tileDescription.get(i).placed != true){
        hasNow.add(g1.tileDescription.get(i));
      }
    }
    //debugging
    System.out.println("hasNow:");
    for (int i = 0; i < hasNow.size(); i++){
      System.out.println(hasNow.get(i).letter);
    }
    return hasNow;
  }
  
  public void wordsPossible(){//checks every word in the words file and stores those that can be made with owned tiles in ArrayList
    ArrayList<Tile> hasNow = grabTiles();
    
  }
  
}