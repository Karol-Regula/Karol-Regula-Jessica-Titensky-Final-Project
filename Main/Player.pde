public class Player {
  int score;
  String name;
  ArrayList<Tile> hasTiles = new ArrayList<Tile>();//will store player's tiles because we will have to cycle the players and the game has to remember this. 

  public Player() {
    score = 0;
    name = "bob";
  }
}