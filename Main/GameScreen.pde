import java.util.*;
import java.io.FileNotFoundException;
class GameScreen {

  boolean selected=false;

  ArrayList<Tile> tileDescription = new ArrayList<Tile>(0);//tiles stored in Arraylist contaning object arrays which in turn store data about tiles 
  ArrayList<Player> players = new ArrayList<Player>(0);
  String[] dict1;
  int[][] multt;
  //methods that need to run while game is in gamemode

  public void printTileDescription() {
    //Tile t = tileDescription.get(0);
    for (int x = 0; x < tileDescription.size(); x++) {
      System.out.println(tileDescription.get(x).letter);
    }
  }

  public void boardSetup() {
    Board b1 = new Board();
    b1.ddraw();
    createTiles();//creates tiles and places them in arrayList
    //printTileDescription();//could not make this into generic print array due to things not being global variables
    placeTiles();//places the tiles from arrayList onto the board, randomly chooses tiles
    createPlayers(1);//can later change arguement when Main Menu works
    multt=b1.mult;
    dict1=loadStrings("words1.txt");
    System.out.println(dict1[dict1.length-1]);
  }

  public void createTiles() {
    int[] tileFrequency = new int[]{9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1};//contains the frequencies of all the letters, SPACES NOT YET INCLUDED
    int[] tileScores = new int[]{1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
    for (int i = 0; i < tileFrequency.length; i ++) {
      for (int j = 0; j < tileFrequency[i]; j++) {
        Tile t1 = new Tile((char)('A' + i), tileScores[i]);
        tileDescription.add(t1);//adds new tile into Arraylist
      }
    }
  }

  public void placeTiles() {
    Collections.shuffle(tileDescription);//shuffles Arraylist so that we do not have to choose elements randomly
    for (int x = 0; x < 15; x++) {
      tileDescription.get(x).xpos = x * size;
      tileDescription.get(x).ypos = 16 * size;
      tileDescription.get(x).origx = x * size;
      tileDescription.get(x).origy = 16 *size;
      tileDescription.get(x).print(tileDescription.get(x).bodyColor);
    }
  }

  public void createPlayers(int n) {
    for (int x = 0; x < n; x++) {
      Player p1 = new Player();
      players.add(p1);
    }
  }

  public boolean detect() {
    Tile t=tileDescription.get(0);
    for (int x = 0; x < tileDescription.size(); x++) {
      if (mouseX - xd > tileDescription.get(x).xpos && mouseX - xd < tileDescription.get(x).xpos + size &&
        mouseY - yd > tileDescription.get(x).ypos && mouseY - yd < tileDescription.get(x).ypos + size) {
        if (mouseY - yd>16 * size) {
          t=tileDescription.get(x);
          t.print(color(204, 159, 102));
          return true;
          /*
          ===========================//this commented code is supposed to make the tile follow the mouse, it does not fully work as of now, mouse detection still works
           while (! mousePressed) {//follows until next mouse press
           System.out.println("and here");
           Tile tc = tileDescription.get(x);
           tc.xpos = mouseX - xd;
           tc.ypos = mouseY;
           tc.print();
           */
        }
      }
    }
    //}
    return false;
  }

  public void move() {
    Tile t=tileDescription.get(0);
    for (int i=0; i<tileDescription.size(); i++) {
      if (tileDescription.get(i).bodyColor==color(204, 159, 102)) {
        t=tileDescription.get(i);
      }
    }
    //System.out.println("pressed");
    fill(255, 255, 255);
    rect(t.xpos+xd, t.ypos+yd, size, size);
    selected=false;
    t.xpos=(mouseX - xd)-(mouseX - xd)%size;
    t.ypos=(mouseY - yd)-(mouseY - yd)%size;//not sure about these
    t.bodyColor = color(180, 102, 5);
    System.out.println(t.score);
    t.print(t.bodyColor);
  }

  public boolean ainb(String a, String[] b) {
    for (int i=0; i<b.length; i++) {
      if (a.length()==1 || a.equals(b[i]) || a.equals("")) {
        return true;
      }
    }
    return false;
  }

  /*
   public boolean asinb(ArrayList<String> a, String[] b) {
   for (int i=0; i<a.size(); i++) {
   if (!(ainb(a.get(i), b))) {
   return false;
   }
   }
   return true;
   }
   
   public String toString(String[] s) {
   String ss="";
   for (int i=0; i<s.length; i++) {
   ss+=s+",";
   }
   return ss;
   }
   
   public ArrayList<String> sep(String letters) {
   ArrayList<String> s=new ArrayList<String>();
   String st="";
   while (letters.length()>0) {
   System.out.println(s);
   if (letters.charAt(0)==' ') {
   if (st.length()>0) {
   s.add(st);
   st="";
   }
   letters=letters.substring(1);
   } else {
   st+=letters.charAt(0);
   letters=letters.substring(1);
   }
   }
   return s;
   }
   */

  public ArrayList<ArrayList<Tile>> readBoard() {
    boolean moreLetters = false;
    ArrayList<ArrayList<Tile>> allWords = new ArrayList<ArrayList<Tile>>();
    ArrayList<Tile> word = new ArrayList<Tile>();//have to make this here, if it is made in an if statement is is not recognized anywhere else
    //horizontal
    for (int j=0; j<15*size; j+=size) {//goes through y-axis
      for (int i=0; i<15*size; i+=size) {//goes through x-axis
        moreLetters = false;
        for (int k=0; k<tileDescription.size(); k++) {//compares coordinates of all tiles to the ones currently in the first two loops
          Tile t1=tileDescription.get(k);
          if (t1.xpos==i && t1.ypos==j) {
            System.out.println("foundmatchX");
            if (moreLetters == false) {//what happens when a NEW word is found (first letter added)
              word.add(t1);
              moreLetters = false;
            }
            for (int m=0; m<tileDescription.size(); m++) {//checks if there are more letters
              Tile t2=tileDescription.get(m);
              //System.out.println("here5");
              if (t2.xpos==i + size && t2.ypos==j) {
                System.out.println("foundnextLetterPossibilityX");
                moreLetters = true;
              }
            }
            if (moreLetters == false) {//if there are no more letters that follow, adds word to ArrayList
              System.out.println("addingwordX");
              ArrayList<Tile> wordCopy = new ArrayList<Tile>();
              for (int b = 0; b < word.size(); b++) {//to get around memory address pointers
                wordCopy.add(word.get(b));
              }
              allWords.add(wordCopy);
              while (word.size() > 0) {
                word.remove(0);
              }
            }
          }
        }
      }
    }
    for (int i=0; i<15*size; i+=size) {//goes through y-axis
      for (int j=0; j<15*size; j+=size) {//goes through x-axis
        moreLetters = false;
        for (int k=0; k<tileDescription.size(); k++) {//compares coordinates of all tiles to the ones currently in the first two loops
          Tile t1=tileDescription.get(k);
          if (t1.xpos==i && t1.ypos==j) {
            System.out.println("foundmatchY");
            if (moreLetters == false) {//what happens when a NEW word is found (first letter added)
              word.add(t1);
              moreLetters = false;
            }
            for (int m=0; m<tileDescription.size(); m++) {//checks if there are more letters
              Tile t2=tileDescription.get(m);
              //System.out.println("here5");
              if (t2.xpos==i && t2.ypos==j + size) {
                System.out.println("foundnextLetterPossibilityY");
                moreLetters = true;
              }
            }
            if (moreLetters == false) {//if there are no more letters that follow, adds word to ArrayList
              System.out.println("addingwordY");
              ArrayList<Tile> wordCopy = new ArrayList<Tile>();
              for (int b = 0; b < word.size(); b++) {//to get around memory address pointers
                wordCopy.add(word.get(b));
              }
              allWords.add(wordCopy);
              while (word.size() > 0) {
                word.remove(0);
              }
            }
          }
        }
      }
    }
    for (int i = 0; i < allWords.size(); i++) {
      String s = "";
      System.out.println(allWords.get(i).size());
      for (int j = 0; j < allWords.get(i).size(); j ++) {
        s+= allWords.get(i).get(j).letter;
      }
      System.out.println(s);
    }
    return allWords;
  }

  public boolean legit() {
    ArrayList<ArrayList<Tile>> allWords = readBoard();
    for (int i=0; i<allWords.size(); i++) {
      String word="";
        for (int j=0; j<allWords.get(i).size(); j++) {
        Tile t= allWords.get(i).get(j);
        word+=t.letter;
      }
      System.out.println("THEWORD"+word+ainb(word,dict1));
      if (ainb(word, dict1)==false) {
        return false;
      }
    }
    return true;
  }

  /*
      ArrayList<String> list=sep(s);
   if (asinb(list, words)==false) {
   System.out.println("NOTHERE");
   return false;
   ////////////////////////////////////////////////////
   for (int i=0; i<15*size; i+=size) {
   String s="";
   for (int j=0; j<15*size; j+=size) {
   boolean b=false;
   for (int k=0; k<tileDescription.size(); k++) {
   Tile t=tileDescription.get(k);
   //System.out.println(i+"jjjj"+j+"kkkkk"+t.xpos+"llll"+t.ypos);
   if (t.xpos==i && t.ypos==j) {
   //System.out.println("LETTER"+t.letter+t.xpos+"  "+t.ypos);
   s+=t.letter;
   b=true;
   //System.out.println("s "+s+b);
   }
   }
   if (!b) {
   //System.out.println("+");
   s+=" ";
   }
   ArrayList<String> list=sep(s);
   if (asinb(list, words)==false) {
   System.out.println("NOTHERE");
   return false;
   }
   }
   //System.out.println(s+"SSS");
   //String[] list0=split("a,,,b,c",',');
   //System.out.println(list0[1]);
   //System.out.println("SIZE"+list.size());
   //System.out.println("word"+list[0]+"...");
   //System.out.println(toString(list));
  /*for (int m=0; m<list.length; m++) {
   try {
   File words = new File("words1.txt");//this won't work on the school computers, I hevn't figured out where processing looks for files, but it's not in any of the directories in the git folder
   Scanner s1 = new Scanner(words);
   while (s1.hasNext()) {//this thing takes forever to run
   if (list[m].equals(s1.next())) {
   return true;
   }
   }
   }
   catch (FileNotFoundException e) {
   System.out.println("Put the file in the right place...");
   }
   }
   
   }
   System.out.println("HERE");
   return true;
   }*/

  public void gray() {
    Board b1=new Board();
    b1.ddraw();
    for (int i=0; i < tileDescription.size(); i++) {//temporary fix to all tiles printing in top left corner, but for now the game effectively has 15 tiles in play
      //======================================================need to fix above line when implementing adding new tiles as the game is played by the players
      fill(180, 102, 5);
      rect(tileDescription.get(i).origx+xd, tileDescription.get(i).origy+yd, size, size);
      tileDescription.get(i).xpos=tileDescription.get(i).origx;
      tileDescription.get(i).ypos=tileDescription.get(i).origy;
      tileDescription.get(i).print(tileDescription.get(i).bodyColor);
    }
  }

  public int multt(int x, int y) {
    System.out.println(x+" "+y);
    return multt[x/size][y/size];
  }

  public int black() {
    Board b1=new Board();
    int score=0;
    //System.out.println(legit() == true);
    if (legit()) {
      System.out.println("MUAHAHA");
      for (int i=0; i<tileDescription.size(); i++) {
        Tile t =tileDescription.get(i);
        if (t.origy!=t.ypos) {
          t.placed=true;
          score+=t.score*multt(t.xpos,t.ypos);
        }
        t.origx=t.xpos;
        t.origy=t.ypos;
      }
    }
    System.out.println("SCORE"+score);
    return score;
  }


  public void mouseClicked() {
    if (16 * size <mouseX - xd && 17 * size >mouseX - xd && 15 * size <mouseY - yd && 16 * size >mouseY - yd) {
      gray();
    } 
    if (16 * size <mouseX - xd && 17 * size >mouseX - xd && 16 * size <mouseY - yd && 17 * size >mouseY - yd) {
      black();
    }
    if (selected) {
      move();
    } else {
      selected=detect();
    }
  }
}