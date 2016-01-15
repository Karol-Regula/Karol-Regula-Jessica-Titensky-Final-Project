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

  public void placeTiles() {
    GameScreen g1 = new GameScreen();
    for (int x = 0; x < 15; x++) {
      hasTiles.get(x).xpos = x * size;
      hasTiles.get(x).ypos = 16 * size;
      hasTiles.get(x).origx = x * size;
      hasTiles.get(x).origy = 16 *size;
      if (hasTiles.get(x).placed == false) {
        hasTiles.get(x).print(hasTiles.get(x).bodyColor);
      }
    }
  }
}