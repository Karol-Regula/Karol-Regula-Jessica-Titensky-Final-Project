import java.util.*;
import java.lang.Math;
import java.io.FileNotFoundException;
class GameScreen {

  boolean selected=false, swap=false;

  ArrayList<Tile> tileDescription = new ArrayList<Tile>(0);//tiles stored in Arraylist contaning object arrays which in turn store data about tiles 
  int upto=0;
  ArrayList<Player> players = new ArrayList<Player>(0);
  ArrayList<ArrayList<Tile>> current =new ArrayList<ArrayList<Tile>>();
  String[] dict1;
  int[][] multt;
  int turn;
  int[] tileScores = new int[]{1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
  //methods that need to run while game is in gamemode

  public void printTileDescription() {
    //Tile t = tileDescription.get(0);
    for (int x = 0; x < tileDescription.size(); x++) {
      System.out.println(tileDescription.get(x).letter);
    }
  }

  public void boardSetup(int players, boolean ai) {
    Board b1 = new Board();
    b1.ddraw();
    createTiles();//creates tiles and places them in arrayList
    //printTileDescription();//could not make this into generic print array due to things not being global variables

    createPlayers(players, ai);//can later change arguement when Main Menu works
    setupPlayers();
    placeTiles();//places the tiles from arrayList onto the board, randomly chooses tiles
    multt=b1.mult;
    dict1=loadStrings("words1.txt");
    //System.out.println(dict1[0]);
    b1.scoreBoard();
  }

  public void createTiles() {
    int b = 0;
    int[] tileFrequency = new int[]{9, 2, 2, 4, 12, 2, 3, 2, 9, 1, 1, 4, 2, 6, 8, 2, 1, 6, 4, 6, 4, 2, 2, 1, 2, 1};//contains the frequencies of all the letters, SPACES NOT YET INCLUDED
    int[] tileScores = new int[]{1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};
    for (int i = 0; i < tileFrequency.length; i ++) {
      for (int j = 0; j < tileFrequency[i]; j++) {
        Tile t1 = new Tile((char)('A' + i), tileScores[i], b);
        tileDescription.add(t1);//adds new tile into Arraylist
        b++;
      }
    }
    Tile t2 = new Tile('*', 0, 99);
    Tile t3 = new Tile('*', 0, 100);
    t2.wasBlank = true;
    t3.wasBlank = true;
    tileDescription.add(t2);
    tileDescription.add(t3);
    Collections.shuffle(tileDescription);//shuffles Arraylist so that we do not have to choose elements randomly
  }

  public void placeTiles() {
    for (int i=0; i<tileDescription.size(); i++) {
      Tile t=tileDescription.get(i);
      if (!t.placed) {
        t.origx=t.xpos=1000000;
        t.origy=t.ypos=1000000;
      }
    }
    int x=1;
    for (int i=0; i<tileDescription.size(); i++) {
      Tile t=tileDescription.get(i);
      if (t.owner.equals(activePlayer().name) && !t.placed) {
        t.origx=t.xpos=x*size;
        t.origy=t.ypos=17*size;
        t.print(t.bodyColor);
        x+=2;
      }
    }
  }

  public void createPlayers(int n, boolean ai) {
    for (int x = 0; x < n; x++) {
      Player p1 = new Player(m1.names[x], false);
      if (p1.name == null || p1.name == " ") {
        p1.name = "Player " + x;
      }
      players.add(p1);
    }
    if (ai) {
      Player p1 = new Player("AI", true);
      players.add(p1);
    }
  }

  public void setupPlayers() {
    for (int i=0; i<players.size(); i++) {
      for (int j=0; j<7; j++) {
        tileDescription.get(i*7+j).owner=players.get(i).name;
      }
    }
    upto=players.size()*7;
    players.get(0).isTurn=true;
  }

  public void refillTiles() {
    for (int i=0; i<players.size(); i++) {
      Player p=players.get(i);
      int n=0;
      for (int j=0; j<tileDescription.size(); j++) {
        Tile t=tileDescription.get(j);
        if (t.owner.equals(p.name) && !t.placed) {
          n++;
        }
      }
      //System.out.println(p.name+"NNN"+n);
      n=7-n;
      int x=upto;
      if (tileDescription.size()<upto+n) {
        for (int j=x; j<tileDescription.size(); j++) {
          tileDescription.get(j).owner=p.name;
          upto++;
        }
      } else {
        for (int j=x; j<x+n; j++) {
          tileDescription.get(j).owner=p.name;
          upto++;
          //System.out.println("UPTOO"+upto);
        }
      }
    }
  }   

  public void nextPlayer() {
    turn++;
    for (int i=0; i<players.size(); i++) {
      players.get(i).isTurn=false;
      if (turn%(players.size())==i) {
        players.get(i).isTurn=true;
      }
    }
  }

  public Player activePlayer() {
    for (int i=0; i<players.size(); i++) {
      if (players.get(i).isTurn==true) {
        return players.get(i);
      }
    }
    //System.out.println("BROKEN");
    return players.get(0);
  }

  public void nextTurn() {//place for all the things that happen after the black button approves the move
    Board b1 = new Board();
    refillTiles();
    nextPlayer();
    if (activePlayer().isAI == true) {
      AI a1 = new AI();
      a1.tryAllWords();
      placeTiles();
    } else {
      placeTiles();
    }
    b1.scoreBoard();
    System.out.println("nowPLAYER"+activePlayer().name);
  }

  public boolean detect() {
    Tile t=tileDescription.get(0);
    for (int x = 0; x < tileDescription.size(); x++) {
      if (mouseX - xd > tileDescription.get(x).xpos && mouseX - xd < tileDescription.get(x).xpos + size &&
        mouseY - yd > tileDescription.get(x).ypos && mouseY - yd < tileDescription.get(x).ypos + size) {
        if (mouseY - yd>16 * size) {
          t=tileDescription.get(x);
          //handle blank tiles
          if (t.letter == '*' && swap==false) {
            PFont f = createFont("Arial", 16, true);
            textFont(f, 12);
            fill(#2E49F0);
            text("Press a key to assign a letter to the blank tile.", 250, 650);
            t.needsLetter = true;
            return false;
          } else {
            t.print(color(204, 159, 102));
            return true;
          }
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
    if ((mouseX > 5 * size && mouseX < 20 * size && mouseY > 2 * size && mouseY < 17 * size) || //fixed the player being able to move the tile to anywhere on the board
      (mouseX - xd > t.xpos && mouseX - xd < t.xpos + size && mouseY - yd > t.ypos && mouseY - yd < t.ypos + size)) {//handles case of deselecting tiles
      //System.out.println("pressed");
      fill(255, 255, 255);
      rect(t.xpos+xd, t.ypos+yd, size, size);
      selected=false;
      t.xpos=(mouseX - xd)-(mouseX - xd)%size;
      t.ypos=(mouseY - yd)-(mouseY - yd)%size;//not sure about these
      t.bodyColor = color(180, 102, 5);
      //System.out.println(t.score);
      t.print(t.bodyColor);
    }
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
            //System.out.println("foundmatchX");
            if (moreLetters == false) {//what happens when a NEW word is found (first letter added)
              word.add(t1);
              moreLetters = false;
            }
            for (int m=0; m<tileDescription.size(); m++) {//checks if there are more letters
              Tile t2=tileDescription.get(m);
              //System.out.println("here5");
              if (t2.xpos==i + size && t2.ypos==j) {
                //System.out.println("foundnextLetterPossibilityX");
                moreLetters = true;
              }
            }
            if (moreLetters == false) {//if there are no more letters that follow, adds word to ArrayList
              //System.out.println("addingwordX");
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
            //System.out.println("foundmatchY");
            if (moreLetters == false) {//what happens when a NEW word is found (first letter added)
              word.add(t1);
              moreLetters = false;
            }
            for (int m=0; m<tileDescription.size(); m++) {//checks if there are more letters
              Tile t2=tileDescription.get(m);
              //System.out.println("here5");
              if (t2.xpos==i && t2.ypos==j + size) {
                //System.out.println("foundnextLetterPossibilityY");
                moreLetters = true;
              }
            }
            if (moreLetters == false) {//if there are no more letters that follow, adds word to ArrayList
              //System.out.println("addingwordY");
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
      //System.out.println(allWords.get(i).size());
      for (int j = 0; j < allWords.get(i).size(); j ++) {
        s+= allWords.get(i).get(j).letter;
      }
      //System.out.println(s);
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
      //System.out.println("THEWORD"+word+ainb(word, dict1));
      if (ainb(word, dict1)==false) {
        return false;
      }
    }
    return true;
  }


  public boolean isTouching(int x, int y) {
    ArrayList<Tile> inplace = new ArrayList<Tile>(0);
    for (int j=0; j<tileDescription.size(); j++) {
      if (tileDescription.get(j).placed) {
        inplace.add(tileDescription.get(j));
      }
    }
    for (int i=0; i<inplace.size(); i++) {
      Tile t=inplace.get(i);
      //System.out.println("LET"+t.letter);
      if (((t.xpos-x)==0 && Math.abs(t.ypos-y)==size) || ((t.ypos-y)==0 && Math.abs(t.xpos-x)==size)) {
        //System.out.println("yes");
        return true;
      }
    }
    //System.out.println("no");
    return false;
  }

  public boolean legitt() {
    ArrayList<Tile> inplace= new ArrayList<Tile>(0);
    for (int j=0; j<tileDescription.size(); j++) {
      if (tileDescription.get(j).placed) {
        inplace.add(tileDescription.get(j));
      }
    }
    if (inplace.size()==0) {
      //System.out.println("SIZE=0");
      for (int i=0; i<tileDescription.size(); i++) {
        Tile t=tileDescription.get(i);
        if (t.xpos==7*size && t.ypos==7*size) {
          return true;
        }
      }
    } else {
      //System.out.println("SIZE!=0");
      for (int i=0; i<tileDescription.size(); i++) {
        Tile t=tileDescription.get(i);
        if (t.ypos!=t.origy) {
          //System.out.println("TESTING"+t.letter);
          if (isTouching(t.xpos, t.ypos)) {
            return true;
          }
        }
      }
    }
    return false;
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
      tileDescription.get(i).bodyColor=color(180, 102, 5);
      tileDescription.get(i).print(tileDescription.get(i).bodyColor);
    }
    for (int j = 0; j < tileDescription.size(); j++) {
      if (tileDescription.get(j).wasBlank) {// && !tileDescription.get(j).placed) {
        System.out.println("reverting");
        tileDescription.get(j).letter = '*';
        tileDescription.get(j).score = 0;
        tileDescription.get(j).print(tileDescription.get(j).bodyColor);
      }
    }
    b1.scoreBoard();
    swap=false;
  }

  public void grayAI() {//simplified for AI usage
    for (int i=0; i < tileDescription.size(); i++) {//temporary fix to all tiles printing in top left corner, but for now the game effectively has 15 tiles in play
      tileDescription.get(i).xpos=tileDescription.get(i).origx;
      tileDescription.get(i).ypos=tileDescription.get(i).origy;
    }
  }

  public int multt(int x, int y) {
    System.out.println(x+" "+y);
    if (multt.length>x/size) {
      if (multt[x/size].length>y/size) {
        return multt[x/size][y/size];
      } else {
        return -10000;
      }
    } else {
      return -10000;
    }
  }

  public void black() {
    System.out.println("black()");
    Board b1=new Board();
    int score=0;
    int put=0;
    //System.out.println(legit() == true);
    //System.out.println(legitt() == true);
    if (legitt()&&legit()) {
      System.out.println("MUAHAHA");
      for (int i=0; i<tileDescription.size(); i++) {
        Tile t =tileDescription.get(i);
        if (t.origy!=t.ypos) {
          t.placed=true;
          put++;
          score+=t.score*multt(t.xpos, t.ypos);
        }
        t.origx=t.xpos;
        t.origy=t.ypos;
      }
      //System.out.println("Score"+score);
    }
    if (score>0) {
      activePlayer().score+=scoreit();
      if (put >= 7) {
        activePlayer().score+=50;
      }
      nextTurn();
    }
    for (int i=0; i<tileDescription.size(); i++) {
      Tile t=tileDescription.get(i);
      if (t.wasBlank && t.placed) {
        t.wasBlank=false;
      }
    }
  }

  public void red() {
    mode = "mainMenu";//sets mode
    MainMenu m1 = new MainMenu();
    m1.setupMenu();
  }

  public void swapselect() {
    System.out.println(swap);
    if (!swap) {
      fill(203, 116, 227);
      rect(16*size+xd, 14*size+yd-20, size*2.5, size);
      fill(255, 255, 255);
      PFont f = createFont("Arial", 16, true);
      textFont(f, 23);
      textSize(25);
      text("Swap", 16*size+xd+14, 14*size+yd-20+28);
      swap=true;
    } else {
      int idk=0;
      //System.out.println("sdjkfhsdjkahgk");
      if (tileDescription.size()-upto>=7) {
        for (int i=0; i<tileDescription.size(); i++) {
          Tile t=tileDescription.get(i);
          if (t.bodyColor==color(204, 159, 102)) {
            idk++;
            //System.out.println(t.letter);
            //upto--;
            //char c=t.letter;
            //int s=t.score;
            /*
            tileDescription.set(i, tileDescription.get(upto));
             tileDescription.get(i).owner=t.owner;
             tileDescription.get(i).bodyColor=color(180, 102, 5);
             tileDescription.set(upto, t);
             tileDescription.get(upto).owner="";
             tileDescription.get(upto).bodyColor=color(180, 102, 5);
             
             t.letter=tileDescription.get(upto).letter;
             t.score=tileDescription.get(upto).score;
             tileDescription.get(upto).letter=c;
             tileDescription.get(upto).score=s;
             System.out.println(t.letter);
             */
            tileDescription.set(i, tileDescription.get(upto));
            tileDescription.get(i).origx=tileDescription.get(i).xpos=t.xpos;
            tileDescription.get(i).origy=tileDescription.get(i).ypos=t.ypos;
            tileDescription.get(i).owner=t.owner;
            //System.out.println("WITH"+tileDescription.get(i).letter);
            tileDescription.set(upto, t);
            tileDescription.get(upto).origx=tileDescription.get(upto).xpos=tileDescription.get(upto).origy=tileDescription.get(upto).ypos=1000;
            tileDescription.get(upto).owner="";
            tileDescription.get(upto).bodyColor=color(180, 102, 5);
            ArrayList<Tile> lastTiles= new ArrayList<Tile>();
            for (int j=upto; j<tileDescription.size(); j++) {
              lastTiles.add(tileDescription.get(j));
            }
            Collections.shuffle(lastTiles);
            for (int j=0; j<lastTiles.size(); j++) {
              tileDescription.set(upto+j, lastTiles.get(j));
            }
            //t.bodyColor=color(180, 102, 5);
            //System.out.println(tileDescription.get(i).letter);
            tileDescription.get(i).print(tileDescription.get(i).bodyColor);
            //upto++;
          }
        }
      }
      fill(158, 45, 189);
      rect(16*size+xd, 14*size+yd-20, size*2.5, size);
      fill(255, 255, 255);
      PFont f = createFont("Arial", 16, true);
      textFont(f, 23);
      textSize(25);
      text("Swap", 16*size+xd+14, 14*size+yd-20+28);
      swap=false;
      if (idk>0) {
        nextTurn();
      }
      selected=false;
      //nextTurn();
    }
  }

  public int scoreit() {
    int s=0;
    ArrayList<ArrayList<Tile>> recent = readBoard();
    ArrayList<ArrayList<Tile>> existing = new ArrayList<ArrayList<Tile>>();
    for (int i=0; i<current.size(); i++) {
      existing.add(current.get(i));
    }
    for (int i=0; i<recent.size(); i++) {
      if (recent.get(i).size()>1) {
        int x=existing.indexOf(recent.get(i));
        if (x==-1) {
          for (int j=0; j<recent.get(i).size(); j++) {
            Tile t=recent.get(i).get(j);
            s+=t.score*multt(t.xpos, t.ypos);
          }
        } else {
          existing.remove(recent.get(i));
        }
      }
    }
    current=readBoard();
    //System.out.println("SSSSSS"+s);
    return s;
  }  


  public void swap() {
    if (swap && mousePressed) {
      detect();
    }
  }


  public void mouseClicked() {
    if (16*size+xd<mouseX && mouseX<16*size+xd+size*2.5 && 15*size+yd-10<mouseY && mouseY<15*size+yd-10+size) {
      gray();
    } 
    if (16*size+xd<mouseX && mouseX<16*size+xd+size*2.5 && 16*size+yd<mouseY && mouseY<16*size+yd+size) {
      //try {
      //Thread.sleep(200);                 //1000 milliseconds is one second.
      //System.out.println("mouseClicked calling black()");
      black();
      // } 
      //catch(InterruptedException ex) {
      //Thread.currentThread().interrupt();
      //}
    }
    if (width-size*2<mouseX && mouseX<width && 0<mouseY && mouseY<size) {
      red();
    }
    if (16*size+xd<mouseX && mouseX<16*size+xd+size*2.5 && 14*size+yd-20<mouseY && mouseY<14*size+yd-20+size) {
      swapselect();
    }
    if (selected) {
      //detect();
      move();
    } else {
      selected=detect();
    }
  }

  void keyPressed() {
    System.out.println(key);
    System.out.println(key > 'a');
    System.out.println(key < 'z');
    char input;
    char theLetter = '}';
    for (int i = 0; i < tileDescription.size(); i++) {
      if (tileDescription.get(i).needsLetter) {
        System.out.println("Needs Letter");
        InputField i1 = new InputField();
        input = i1.listen();
        /*
        if (Character.getNumericValue(input) >= Character.getNumericValue('a') && Character.getNumericValue(input) <= Character.getNumericValue('z')) {
         theLetter = Character.toUpperCase(input);
         } else if (Character.getNumericValue(input) >= Character.getNumericValue('A') && Character.getNumericValue(input) <= Character.getNumericValue('Z')) {
         theLetter = input;
         }
         */
        if (input >= 'a' && input <= 'z') {
          theLetter = Character.toUpperCase(input);
        } else if (input >= 'A' && input <= 'Z') {
          theLetter = input;
        }
        if (theLetter != '}') {
          System.out.println(theLetter);
          tileDescription.get(i).letter = theLetter;
          tileDescription.get(i).needsLetter = false;//tileDescription.get(i).wasBlank = false;
          //assinging the score to the letter
          tileDescription.get(i).score = tileScores[(Character.getNumericValue(tileDescription.get(i).letter)) - (Character.getNumericValue('a'))];
          System.out.println(""+tileDescription.get(i).letter+""+tileDescription.get(i).score);
          tileDescription.get(i).print(tileDescription.get(i).bodyColor);
          //gray();
          fill(255, 255, 255);
          noStroke();
          rect(200, 640, size*15, 15);
          stroke(0);
          System.out.println("YASS");
        }
      }
    }
  }
}