public class Player {
  int score;
  String name;
  boolean isTurn;
  ArrayList<Tile> hasTiles = new ArrayList<Tile>();//will store player's tiles because we will have to cycle the players and the game has to remember this. 

  public Player(int x) {
    String named = "";
    named += x;
    score = 0;
    name = named;
    isTurn = false;
  }
}