public class AI extends GameScreen {
  int level;
  String[] dict1 = loadStrings("words1.txt");
  ArrayList<Tile> hasNow;
  //ArrayList<ArrayList<Integer>> scoreIndexX = new ArrayList<ArrayList<Integer>>(); //this is different every turn
  //ArrayList<ArrayList<Integer>> scoreIndexY = new ArrayList<ArrayList<Integer>>(); //this is different every turn
  ArrayList<Integer> scoreIndexX = new ArrayList<Integer>();
  ArrayList<Integer> scoreIndexY = new ArrayList<Integer>();
  ArrayList<ArrayList<Tile>> tileIndexX = new ArrayList<ArrayList<Tile>>();
  ArrayList<ArrayList<Tile>> tileIndexY = new ArrayList<ArrayList<Tile>>();
  int currentWordTested = 0;

  public AI() {
    level = 0;
  }

  public ArrayList<Tile> grabTiles() {//produces an ArrayList of tiles that the AI has that particular turn
    ArrayList<Tile> hasNow = new ArrayList<Tile>();
    for (int i = 0; i < g1.tileDescription.size(); i ++) {
      if (g1.tileDescription.get(i).owner == g1.activePlayer().name && g1.tileDescription.get(i).placed != true) {
        hasNow.add(g1.tileDescription.get(i));
      }
    }
    //debugging
    /*
    System.out.println("hasNow:");
     for (int i = 0; i < hasNow.size(); i++) {
     System.out.println(hasNow.get(i).letter);
     }
     */
    return hasNow;
  }

  public ArrayList<ArrayList<Tile>> wordsPossible() {//checks every word in the words file and stores those that can be made with owned tiles in ArrayList
    ArrayList<ArrayList<Tile>> possibleWords = new ArrayList<ArrayList<Tile>>();
    ArrayList<Tile> hasNow = grabTiles();
    ArrayList<Tile> copy = new ArrayList<Tile>();
    String word = "";
    updateHasNow();
    for (int i = 0; i < dict1.length; i++) {
      //System.out.println(i);
      word = dict1[i];
      if (canMake(word)) {
        System.out.println(word);
        for (int x = 0; x < hasNow.size(); x++) {
          copy.add(hasNow.get(x));
        }
        ArrayList<Tile> current = new ArrayList<Tile>();
        while (word.length() > 0) {
          for (int k = 0; k < copy.size(); k++) {
            if (copy.get(k).letter == word.charAt(0)) {
              word = word.substring(1, word.length());
              System.out.println("word: "+word);
              current.add(copy.get(k));
              copy.remove(k);
              k--;
              if (word.length() == 0) {
                k += 1000;
              }
            }
          }
        }
        if (current.size() > 0) {
          System.out.println("here 101");
          for (int m = 0; m < current.size(); m++) {
            System.out.println(current.get(m).letter);
          }
          possibleWords.add(current);
        }
      }
    }
    //debugging
    for (int i = 0; i < possibleWords.size(); i++) {
      for (int j = 0; j < possibleWords.get(i).size(); j++) {
        System.out.print(possibleWords.get(i).get(j).letter);
      }
      System.out.println();
    }
    return possibleWords;
  }

  public boolean canMake(String word) {//checks if the given word can be made using the tiles the AI has
    //hasNow = grabTiles();//re doing this 58k times is extremely inefficient, fix if slow
    ArrayList<Tile> copy = new ArrayList<Tile>();
    for (int x = 0; x < hasNow.size(); x++) {
      copy.add(hasNow.get(x));
    }
    for (int i = 0; i < word.length(); i++) {
      for (int j = 0; j < copy.size(); j++) {
        if (copy.get(j).letter == word.charAt(i)) {
          copy.remove(j);
          j += 1000;
          word = word.substring(1, word.length());
          i--;
        }
      }
    }
    if (word.length() == 0) {
      System.out.println("canMake() == true)");
      return true;
    }
    return false;
  }

  public void tryAllWords() {//tries to insert all of the words into all avaliable posisions on the board
    ArrayList<ArrayList<Tile>> possibleWords = wordsPossible();
    prepareIndexes();
    for (int i = 0; i < possibleWords.size() && i < 8; i++) {//possibleWords.size();
      currentWordTested = i;
      tryWord(possibleWords.get(i));
    }
    printIndexes();
    makePlay();
  }

  public void prepareIndexes() {
    while (scoreIndexX.size() > 0) {
      scoreIndexX.remove(0);
    }
    while (scoreIndexY.size() > 0) {
      scoreIndexY.remove(0);
    }
    while (tileIndexX.size() > 0) {
      scoreIndexY.remove(0);
    }
    while (tileIndexY.size() > 0) {
      scoreIndexY.remove(0);
    }
  }

  public void printIndexes() {//method only for debuggin'
    for (int x = 0; x < scoreIndexX.size(); x++) {
      if (scoreIndexX.get(x) > 0) {
        System.out.println("scoreIndexX, position: "+x+"value: "+scoreIndexX.get(x));
      }
    }
    for (int x = 0; x < scoreIndexY.size(); x++) {
      if (scoreIndexY.get(x) > 0) {
        System.out.println("scoreIndexY, position: "+x+"value: "+scoreIndexY.get(x));
      }
    }
  }

  public void tryWord(ArrayList<Tile> input) {//tries all possible positions for one word
    int score = 0;
    boolean badOverlap = false;
    ArrayList<Tile> useless = new ArrayList<Tile>();
    for (int i = 3 * size; i < 16 * size; i+= size) {//first weird for loops I ever wrote//ydimension//horizontal
      for (int j = 6 * size; j < ((19 * size) - ((input.size() * size))); j+= size) {//xdimension
        for (int x = 0; x < input.size(); x++) {
          input.get(x).xpos = j + x * size;
          input.get(x).ypos = i;
          for (int z = 0; z < g1.tileDescription.size(); z++) {
            if (g1.tileDescription.get(z).xpos == input.get(x).xpos && g1.tileDescription.get(z).ypos == input.get(x).ypos && g1.tileDescription.get(z).letter != input.get(x).letter) {
              badOverlap = true;
              System.out.println("Bad overlap");
            }
          }
        }
        if (g1.legitt() && g1.legit() && !badOverlap) {
          //System.out.println("legits passedx============================================================");
          for (int k = 0; k < g1.tileDescription.size(); k++) {
            Tile t = g1.tileDescription.get(k);
            if (t.origy!=t.ypos) {
              //t.placed=true;
              System.out.println("scoring=============");
              score+=t.score * g1.multt(t.xpos - xd, t.ypos - yd);
            }
          }
          scoreIndexX.add(score);
          ArrayList<Tile> inputMod = new ArrayList<Tile>(); 
          for (int n = 0; n < input.size(); n++) {
            Tile t1 = new Tile(input.get(n).letter, input.get(n).score, input.get(n).number);//this might be the cause of future bugs, be weary
            t1.xpos = input.get(n).xpos;
            t1.ypos = input.get(n).ypos;
            inputMod.add(t1);
          }
          //t.xpos=t.origx;
          //t.ypos=t.origy;
          tileIndexX.add(inputMod);//these index all tries, is inefficient, have to make this index only successful tries
          score = 0;
        } else {
          scoreIndexX.add(0);
          tileIndexX.add(useless);
        }
        badOverlap = false;
        g1.grayAI();
      }
    }
    /*
    for (int i = 2 * size; i < 17 * size; i+= size) {//first weird for loops I ever wrote//ydimension//vertical
     for (int j = 5 * size; j < 20 * size; j+= size) {//xdimension
     for (int x = 0; x < input.size(); x++) {
     input.get(x).xpos = j;
     input.get(x).ypos = i + x * size;
     if (g1.legitt() && g1.legit()) {
     //System.out.println("legits passedy===========================================================");
     for (int k = 0; k < g1.tileDescription.size(); k++) {
     Tile t = g1.tileDescription.get(k);
     if (t.origy!=t.ypos) {
     t.placed=true;
     System.out.println("scoring=============");
     score+=t.score;//* g1.multt(t.xpos, t.ypos);
     }
     //t.origx=t.xpos;
     //t.origy=t.ypos;
     }
     scoreIndexY.add(score);
     score = 0;
     } else {
     scoreIndexY.add(0);
     }
     grayAI();
     }
     }
     }
     */
  }

  public void makePlay() {
    boolean end = false;
    Tile t1 = new Tile('a', 1, 1);
    for (int i = 0; i < scoreIndexX.size(); i++) {
      if (scoreIndexX.get(i) > 6) {
        //debugging
        System.out.println("Found a score of "+scoreIndexX.get(i));
        System.out.println("Length of word: " + tileIndexX.get(i).size());
        for (int d = 0; d < tileIndexX.get(i).size(); d++) {
          System.out.println(tileIndexX.get(i).get(d).xpos);
          System.out.println(tileIndexX.get(i).get(d).ypos);
          System.out.println(tileIndexX.get(i).get(d).letter);
        }       
        for (int j = 0; j < tileIndexX.get(i).size(); j++) {
          for (int k = 0; k < g1.tileDescription.size(); k++) {
            System.out.println(g1.tileDescription.get(k).number + " " + tileIndexX.get(i).get(j).number);
            if (g1.tileDescription.get(k).number == tileIndexX.get(i).get(j).number) {
              g1.tileDescription.get(k).xpos = tileIndexX.get(i).get(j).xpos;
              g1.tileDescription.get(k).ypos = tileIndexX.get(i).get(j).ypos;
              System.out.println("number matched" + g1.tileDescription.get(k).xpos + " " + (g1.tileDescription.get(k).ypos));
            }
          }
        }
        end = true;
        break;
      }
      if (end) {
        g1.black();
        break;
      }
    }
  }

  public void updateHasNow() {
    hasNow = grabTiles();
  }
}