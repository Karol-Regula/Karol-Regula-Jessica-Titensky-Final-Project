import java.util.*;
import java.io.FileNotFoundException;
class GameScreen {

  boolean selected=false;

  ArrayList<Tile> tileDescription = new ArrayList<Tile>(0);//tiles stored in Arraylist contaning object arrays which in turn store data about tiles 
  ArrayList<Player> players = new ArrayList<Player>(0);
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
    printTileDescription();//could not make this into generic print array due to things not being global variables
    placeTiles();//places the tiles from arrayList onto the board, randomly chooses tiles
    createPlayers(1);//can later change arguement when Main Menu works
  }
  //System.out.println(tileDescription.get(3).xpos + " " + tileDescription.get(3).ypos);

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
      tileDescription.get(x).print();
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
    //if (mousePressed) {//will check if mouse was pressed on a tile, tile will follow mouse
    for (int x = 0; x < tileDescription.size(); x++) {
      if (mouseX > tileDescription.get(x).xpos && mouseX < tileDescription.get(x).xpos + size &&
        mouseY > tileDescription.get(x).ypos && mouseY < tileDescription.get(x).ypos + size) {
        if (mouseY>16 * size) {
          System.out.println("got here");
          t=tileDescription.get(x);
          t.select();
          return true;
          /*
          ===========================//this commented code is supposed to make the tile follow the mouse, it does not fully work as of now, mouse detection still works
           while (! mousePressed) {//follows until next mouse press
           System.out.println("and here");
           Tile tc = tileDescription.get(x);
           tc.xpos = mouseX;
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
    System.out.println("pressed");
    fill(255, 255, 255);
    rect(t.xpos, t.ypos, size, size);
    selected=false;
    t.xpos=mouseX-mouseX%size;
    t.ypos=mouseY-mouseY%size;//not sure about these
    t.bodyColor = color(180, 102, 5);
    System.out.println(t.score);
    t.print();//why does this not print the score.
  }

  public boolean ainb(String a, String[] b) {
    for (int i=0; i<b.length; i++) {
      if (a.equals("")) {
      } else {
        if (a.equals(b[i])) {
          return true;
        }
      }
    }
    return false;
  }

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

  public boolean legit() {
    String[] words=loadStrings("words1.txt");
    System.out.println(words[0]);
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
       */
    }
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
       */
    }
    System.out.println("HERE");
    return true;
  }



  public void mouseClicked() {
    if (16 * size <mouseX && 17 * size >mouseX && 15 * size <mouseY && 16 * size >mouseY) {
      Board b1=new Board();
      b1.ddraw();
      for (int i=0; i < tileDescription.size(); i++) {//temporary fix to all tiles printing in top left corner, but for now the game effectively has 15 tiles in play
        //======================================================need to fix above line when implementing adding new tiles as the game is played by the players
        fill(180, 102, 5);
        rect(tileDescription.get(i).origx, tileDescription.get(i).origy, size, size);
        tileDescription.get(i).xpos=tileDescription.get(i).origx;
        tileDescription.get(i).ypos=tileDescription.get(i).origy;
        tileDescription.get(i).print();
      }
    } 
    if (16 * size <mouseX && 17 * size >mouseX && 16 * size <mouseY && 17 * size >mouseY) {
      System.out.println(legit() == true);
      if (legit()) {
        System.out.println("MUAHAHA");
        for (int i=0; i<tileDescription.size(); i++) {
          Tile t =tileDescription.get(i);
          if (t.origy!=t.ypos) {
            t.placed=true;
          }
          t.origx=t.xpos;
          t.origy=t.ypos;
        }
      }
    }
    if (selected) {
      move();
    } else {
      selected=detect();
    }
  }
}