class Board {

  int w=15, h=15, s=30;

  void ddraw() {
    int[][][]colors=new int[8][8][3];
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        for (int k=0; k<3; k++) {
          colors[i][j][k]=255;
        }
      }
    }
    colors[0][0][0]=255;
    colors[0][0][1]=128;
    colors[0][0][2]=0;
    colors[0][7]=colors[7][0]=colors[0][0];
    colors[0][3][0]=0;
    colors[0][3][1]=128;
    colors[0][3][2]=255;
    colors[3][0]=colors[6][2]=colors[7][3]=colors[3][7]=colors[2][6]=colors[6][6]=colors[0][3];
    colors[5][1][0]=0;
    colors[5][1][1]=255;
    colors[5][1][2]=0;
    colors[1][5]=colors[5][5]=colors[5][1];
    colors[1][1][0]=255;
    colors[1][1][1]=0;
    colors[1][1][2]=0;
    colors[2][2]=colors[3][3]=colors[4][4]=colors[7][7]=colors[1][1];  

    background(255, 255, 255);  
    for (int i=0; i<w; i++) {
      line(i*s, 0, i*s, height);
    }
    for (int i=0; i<h; i++) {
      line(0, i*s, width, i*s);
    }
    for (int i=0; i<8; i++) {
      for (int j=0; j<8; j++) {
        fill(colors[i][j][0], colors[i][j][1], colors[i][j][2]);
        rect(i*s, j*s, s, s);
      }
    }
    for (int i=8; i<15; i++) {
      for (int j=0; j<8; j++) {
        fill(colors[14-i][j][0], colors[14-i][j][1], colors[14-i][j][2]);
        rect(i*s, j*s, s, s);
      }
    }  
    for (int i=0; i<8; i++) {
      for (int j=8; j<15; j++) {
        fill(colors[i][14-j][0], colors[i][14-j][1], colors[i][14-j][2]);
        rect(i*s, j*s, s, s);
      }
    }  
    for (int i=8; i<15; i++) {
      for (int j=8; j<15; j++) {
        fill(colors[14-i][14-j][0], colors[14-i][14-j][1], colors[14-i][14-j][2]);
        rect(i*s, j*s, s, s);
      }
    }
  }
}