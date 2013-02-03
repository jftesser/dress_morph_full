class HScrollbar
{
  int swidth, sheight;    // width and height of bar
  int xpos, ypos;         // x and y position of bar
  float spos, newspos;    // x position of slider
  int sposMin, sposMax;   // max and min values of slider
  int loose=2;              // how loose/heavy
  boolean over;           // is the mouse over the slider?
  boolean locked;
  float ratio;
  float minValue, maxValue;

  HScrollbar (int xp, int yp, int sw, int sh, float minv, float maxv) {
    swidth = sw;
    sheight = sh;
    int widthtoheight = sw - sh;
    ratio = (float)sw / (float)widthtoheight;
    xpos = xp;
    ypos = yp-sheight/2;
    spos = xpos + swidth/2 - sheight/2 -20;
    newspos = spos;
    sposMin = xpos;
    sposMax = xpos + swidth - sheight;
     
    minValue = minv;
    maxValue = maxv;
  }

  void update(float minv, float maxv) {
    minValue = minv;
    maxValue = maxv;
    
    if(over()) {
      over = true;
    } else {
      over = false;
    }
    if(mousePressed && over) {
      locked = true;
    }
    if(!mousePressed) {
      locked = false;
    }
    if(locked) {
      newspos = constrain(mouseX-sheight/2, sposMin, sposMax);
    }
    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/loose;
    }
  }

  int constrain(int val, int minv, int maxv) {
    return min(max(val, minv), maxv);
  }

  boolean over() {
    if(mouseX > xpos && mouseX < xpos+swidth &&
    mouseY > ypos && mouseY < ypos+sheight) {
      return true;
    } else {
      return false;
    }
  }

  void display() {
    
    //rect(xpos, ypos, swidth, sheight);//background rectangle
    
    noStroke();
    strokeWeight(1);
    if(over || locked) {
      //fill(cmode);
      //stroke(cmode);
    } else {
      fill(120);
      stroke(120);
    }
    rect(spos, ypos, sheight, sheight); 
    for (int i=xpos; i<swidth+xpos+10; i+=10) {
      point(i, ypos+ sheight/2);
    }
    
  }

  float getPos() {
    return spos;
  }
  
  float getValue() {
    return (map(spos,sposMin,sposMax,minValue,maxValue));
  }
  float getMax() {
     return (maxValue);
  }
  
  void setPos(float setPosition) {
    if(setPosition<sposMax && newspos>sposMin){
      newspos=setPosition;
    }
    //spos = newspos;
    if(abs(newspos - spos) > 1) {
      spos = spos + (newspos-spos)/2;
    }
  }
}

