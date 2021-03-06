class MainMenu {

  int players;
  boolean ai;
  boolean aii =false; 
  String[] names;
  int active;


  /*
 public void detect() {
   if (mousePressed && mouseY - yd < 200 && mouseY - yd > 100 && mouseX - xd > 75 && mouseY - yd < 375) {//checks if mouse was pressed on the button
   mode = "gameScreen";//changes mode to the gameScreen
   g1.boardSetup(0, false);//runs only once, sets up board
   }
   }
   */

  public void setupMenu() {
    background(13, 42, 158);
    //rect(75+xd, 100+yd, 300, 100);
    PFont f = createFont("Comic Sans MS Bold", 48); //HATERS GONNA HATE, BUT COMIC SANS IS LOVE, COMIC SANS IS LIFE, //...
    textFont(f, 48);
    fill(255, 122, 13);
    fill(255, 122, 13);
    textSize(30);
    text("How many players?", 300, 150);
    fill(255, 122, 13);
    textSize(20);
    text("Play with an AI?", 275, 275);
    setupPlayers();
    setupAI();
    fill(171, 247, 182);
    rect(700, 600, 100, 60);
    fill(255, 122, 13);
    textSize(35);
    text("Start", 705, 642);
  }

  public void setupPlayers() {
    fill(255, 122, 13);
    textSize(30);
    //text("How many players?", 300, 150);
    fill(171, 247, 182);
    rect(300, 175, 50, 50);
    rect(375, 175, 50, 50);
    rect(450, 175, 50, 50);
    rect(525, 175, 50, 50);
    fill(255, 122, 13);
    text("1", 318, 212);
    text("2", 393, 212);
    text("3", 468, 212);
    text("4", 543, 212);
  }

  public void setupAI() {
    fill(255, 122, 13);
    textSize(20);
    //text("Play with an AI?", 275, 275);
    fill(171, 247, 182);
    rect(475, 250, 50, 30);
    rect(550, 250, 50, 30);
    fill(255, 122, 13);
    text("yes", 483, 272);
    text("no", 563, 272);
  }

  public void setupNames() {
    fill(13, 42, 158);
    noStroke();
    rect(350, 300, 400, 200);
    stroke(0);
    for (int i=0; i<players; i++) {
      fill(171, 247, 182);
      rect(370, 330+40*i, 140, 30);
      fill(255, 122, 13);
      textSize(20);
      text("Player "+(i+1), 380, 353+40*i);
    }
    names= new String[players];
  }

  public void write() {
    if (active!=0) {
      if (key==ENTER || key==RETURN) {
        fill(171, 247, 182);
        rect(370, 330+40*(active-1), 140, 30);
        fill(255, 122, 13);
        textSize(15);
        text(names[active-1], 370, 353+40*(active-1));
        active=0;
      } else {
        if (key==BACKSPACE && names[active-1].length()>0) {
          names[active-1]=names[active-1].substring(0, names[active-1].length()-1);
        } else {
          if (names[active-1].length()<=8 && key!=CODED) {
            names[active-1]+=key;
          }
        }
        System.out.println("GOING"+active+"SOFAR"+names[active-1]);
        update(active-1);
      }
    }
  }


  public void update(int player) {
    fill(69, 209, 90);
    rect(370, 330+40*player, 140, 30);
    fill(255, 122, 13);
    textSize(15);
    text(names[active-1], 370, 353+40*player);
  }







  public void mouseClicked() {
    if (300<mouseX && mouseX<350 && 175<mouseY && mouseY<225) {
      setupPlayers();
      players=1;
      fill(69, 209, 90);
      rect(300, 175, 50, 50);
      fill(255, 122, 13);
      textSize(30);
      text("1", 318, 212);
      setupNames();
    }
    if (375<mouseX && mouseX<425 && 175<mouseY && mouseY<225) {
      setupPlayers();
      players=2;
      fill(69, 209, 90);
      rect(375, 175, 50, 50);
      fill(255, 122, 13);
      textSize(30);
      text("2", 393, 212);
      setupNames();
    }
    if (450<mouseX && mouseX<500 && 175<mouseY && mouseY<225) {
      setupPlayers();
      players=3;
      fill(69, 209, 90);
      rect(450, 175, 50, 50);
      fill(255, 122, 13);
      textSize(30);
      text("3", 468, 212);
      setupNames();
    }
    if (525<mouseX && mouseX<575 && 175<mouseY && mouseY<225) {
      setupPlayers();
      players=4;
      fill(69, 209, 90);
      rect(525, 175, 50, 50);
      fill(255, 122, 13);
      textSize(30);
      text("4", 543, 212);
      setupNames();
    }
    if (475<mouseX && mouseX<525 && 250<mouseY && mouseY<280) {
      setupAI();
      ai=true;
      aii=true;
      fill(69, 209, 90);
      rect(475, 250, 50, 30);
      fill(255, 122, 13);
      textSize(20);
      text("yes", 483, 272);
    }
    if (550<mouseX && mouseX<600 && 250<mouseY && mouseY<280) {
      setupAI();
      ai=false;
      aii=true;
      fill(69, 209, 90);
      rect(550, 250, 50, 30);
      fill(255, 122, 13);
      textSize(20);
      text("no", 563, 272);
    }
    if (370<mouseX && mouseX<510 && 330<mouseY && mouseY<360 && players>=1) {
      if (active==0) {
        fill(69, 209, 90);
        rect(370, 330, 140, 30);
        names[0]=" ";
        active=1;
        //System.out.println("ONE");
        //System.out.println(mouseY);
      }
    }
    if (370<mouseX && mouseX<510 && 370<mouseY && mouseY<400 && players>=2) {
      if (active==0) {
        fill(69, 209, 90);
        rect(370, 370, 140, 30);
        names[1]=" ";
        active=2;
      }
    }
    if (370<mouseX && mouseX<510 && 410<mouseY && mouseY<440 && players>=3) {
      if (active==0) {
        fill(69, 209, 90);
        rect(370, 410, 140, 30);
        names[2]=" ";
        active=3;
      }
    }
    if (370<mouseX && mouseX<510 && 450<mouseY && mouseY<470 && players>=4) {
      if (active==0) {
        fill(69, 209, 90);
        rect(370, 450, 140, 30);
        names[3]=" ";
        active=4;
      }
    }
    if (700<mouseX && mouseX<800 && 600<mouseY && mouseY<660) {
      if (players!=0 && aii) {
        mode="gameScreen";
        g1=new GameScreen();
        g1.boardSetup(players, ai);
      }
    }
  }
}