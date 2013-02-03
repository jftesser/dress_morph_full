class ImageButton {
  int x, y;
  int w, h;
  PImage overimg, staticimg, activeimg, currentimg;
  boolean over = false;
  boolean pressed = false;   
  boolean active = false;
  String label;
  
  ImageButton(int ix, int iy, String ilabel) {
    x=ix;
    y=iy;
    label=ilabel;
    
   // overimg = loadImage(label + "_over.png");
   
   // staticimg = loadImage(label + "_static.png");
   // activeimg = loadImage(label + "_active.png");
    staticimg = loadImage(label + ".png");
    activeimg = loadImage(label + "-active.png");
    
    currentimg = staticimg;
    
    w= staticimg.width;
    h= staticimg.height;
    
  }
  
  void update() 
  {
    over();
   // pressed();
    if(over && active==false) {
    // currentimg = overimg;
    } else if (active){
     currentimg = activeimg;
    } else {
      currentimg = staticimg;
    }
  }
  
  void display() {
    image(currentimg,x,y);
  }
  
  void pressed() {
    //if(over && mousePressed) {
      pressed = !pressed;
    //}   
  }
  
  
  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
  }
  
  void over() 
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
  
  boolean ifOver() {
    return over;
  }
  
  void setState(boolean state) {
    active = state;
  }
  void toggleState(){
    active = !active;
  }
  
  boolean getState() {
    return active;
  }
  
}


class Button
{
  int x, y;
  int w, h;
  color basecolor, highlightcolor,downcolor;
  color currentcolor,textcolor;
  boolean over = false;
  boolean pressed = false;   
  boolean active = false;
  String label;
  
  Button(int ix, int iy, int iw, int ih, String ilabel) {
    x=ix;
    y=iy;
    w=iw;
    h=ih;
    label=ilabel;
    basecolor=color(70);
    highlightcolor=color(120);
    downcolor=color(40);
    textcolor=color(255);
  }
  
  void pressed() {
    //if(over && mousePressed) {
      pressed = !pressed;
    //}   
  }
  
  
  boolean overRect(int x, int y, int width, int height) {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
  }
  
  void update() 
  {
    over();
   // pressed();
    if(pressed) {
     currentcolor=downcolor;
     textcolor=color(255);
    } else if (over){
     currentcolor=highlightcolor;
     textcolor=color(0);
    } else {
      currentcolor=basecolor;
      textcolor=color(0);
    }
  }
  
  void over() 
  {
    if( overRect(x, y, w, h) ) {
      over = true;
    } else {
      over = false;
    }
  }
  
  boolean ifOver() {
    return over;
  }
  
  void setState(boolean state) {
    active = state;
  }
  boolean getState() {
    return pressed;
  }
  
  void display() {
    textSize(12);
    if (over) {
      stroke(255);
    } else {
      noStroke();
    }
    fill(currentcolor);
    rect(x,y,w,h);
    
    if (pressed) {
      fill(255);
      ellipse(x+7,y+h/2,7,7);
    }
    
    fill(textcolor);
    text(label, x+15,y+h/2+5);
  }
}



