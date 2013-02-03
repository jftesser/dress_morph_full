import processing.opengl.*;

import toxi.geom.*;
import toxi.geom.mesh.*;

import toxi.processing.*;

import processing.pdf.*;

TriangleMesh mesh, mesh2;
ToxiclibsSupport gfx;

TweenMesh shoe;

Garment currSize;

Garment[] sizes;

float displaceY=400;
float displaceX;
float targetdisplaceX;
float rotateval=100;
float rotatetarget = 180;

 float SkirtFullness=0;
 float targetSkirtFullness=0;
 float SkirtLength=0.4;
 float targetSkirtLength=.6;

 float BodiceSharpness=0.5;
 float BodiceDepth=0.5;

 float SleeveLength=1;
 float SleevePoofiness=0.5;

boolean showWireframe = false;
int editmode = 2; //start with the skirt

int buttonx=640;
int buttony=120;
ImageButton bodicebutton, skirtbutton, sleevebutton, peplumbutton, sizebutton, diybutton, buybutton;
ImageButton black_render, wireframe_render;
int bottombuttony = 1024-150;

float targetsizepanelx= -247;
float sizepanelx= -247;
float targetbuypanelx= 769;
float buypanelx= 769;

PImage backgroundimg, sizepanel, buypanel, cottontag,silktag,wooltag;
PFont font;
PImage mannequin;

boolean showPattern = false;

void setup() {
  size(768, 1024, OPENGL);
  gfx=new ToxiclibsSupport(this);
  displaceX = width/2;
  targetdisplaceX = width/2;

sizes = new Garment[6];
sizes[0] = new Garment("2");
sizes[1] = new Garment("4");
sizes[2] = new Garment("6");
sizes[3] = new Garment("8");
sizes[4] = new Garment("10");
sizes[5] = new Garment("12");

currSize = sizes[0];

  updateGarment();
  
  bodicebutton = new ImageButton(buttonx, buttony, "bodicebutton");
  skirtbutton = new ImageButton(buttonx, buttony+90, "skirtbutton");
  skirtbutton.setState(true);
  sleevebutton = new ImageButton(buttonx, buttony+90*2, "sleevebutton");
  peplumbutton = new ImageButton(buttonx, buttony+90*3, "peplumbutton");
  
  black_render = new ImageButton(50, buttony, "blackrender");
  wireframe_render = new ImageButton(50+50, buttony, "wireframe_render");
  
  sizebutton = new ImageButton(0, bottombuttony, "sizebutton");
  diybutton = new ImageButton(175, bottombuttony, "diybutton");
  buybutton = new ImageButton(287+175, bottombuttony, "buybutton");
  
  backgroundimg = loadImage("background.jpg");
  sizepanel = loadImage("sizepanel.png");
  buypanel = loadImage("buypanel.png");
  cottontag = loadImage("cotton_tag.png");
  silktag = loadImage("silk_tag.png");
  wooltag = loadImage("wool_tag.png");
  mannequin = loadImage("mannequin_taller.png");
  
  font = loadFont("BrandonGrotesque-Regular-24.vlw");
  smooth();
  noCursor();
}

void draw() {
  background(backgroundimg);
  
  pushMatrix();
  lights();
  translate(displaceX, displaceY, 0);
  rotateX(PI);
  rotateY(rotateval*PI/180);
  hint(ENABLE_DEPTH_TEST);
  
  if (showWireframe) {
    stroke(0);
    fill(255,255,255,200);
  } else {
    fill(55);
    noStroke();
  }

  scale(.6);
  
  if (!showPattern) {
  currSize.render();
  }
  
  rotateval = tween(rotatetarget, rotateval, .01);
  SkirtFullness = tween(targetSkirtFullness, SkirtFullness, .04);
  SkirtLength = tween(targetSkirtLength, SkirtLength, .04);
  updateGarment();
  popMatrix();
  //image(mannequin, displaceX-220, 0);
  
  hint(DISABLE_DEPTH_TEST);
  if (showPattern) {
    stroke(0);
    fill(255,255,255,200);
    pushMatrix();
    scale(.6);
    translate(width*.2,height*.3);
    currSize.pattern.render();
    popMatrix();
  }
  
  sizepanelx = tween(targetsizepanelx, sizepanelx, .05);
  buypanelx = tween(targetbuypanelx, buypanelx, .05);
  displaceX = tween(targetdisplaceX, displaceX, .05);
  
  bodicebutton.update();
  bodicebutton.display();
  skirtbutton.update();
  skirtbutton.display();
  sleevebutton.update();
  sleevebutton.display();
  peplumbutton.update();
  peplumbutton.display();
  
  sizebutton.update();
  sizebutton.display();
  diybutton.update();
  diybutton.display();
  buybutton.update();
  buybutton.display();
  
  black_render.update();
  black_render.display();
  wireframe_render.update();
  wireframe_render.display();
  
  image(sizepanel,sizepanelx,57);
  image(buypanel,buypanelx,57);
  
  fill(44,171,232,150);
  noStroke();
  ellipse(mouseX,mouseY,20,20);
}


float tween(float target, float val, float easing) {
  float dx = target - val;
  if (abs(dx) > .05) {
    val+=dx * easing;
  }
  return val;
}

void updateGarment() {
  currSize.setSkirtFullness(SkirtFullness);
  currSize.setSkirtLength(SkirtLength);
  currSize.setSkirtWaviness(1);
  
  currSize.setBodiceSharpness(BodiceSharpness);
  currSize.setBodiceDepth(BodiceDepth);
  
  currSize.setSleeveLength(SleeveLength);
  currSize.setSleevePoofiness(SleevePoofiness);
}

void keyPressed() {
 if (key == 'S') {
  currSize.savePattern();
 } 
 if (key == 'w') {
   showWireframe = !showWireframe;
 }
 
 if (key == '1') {
   currSize = sizes[0];
   updateGarment();
 }
 if (key == '2') {
   currSize = sizes[1];
   updateGarment();
 }
 if (key == '3') {
   currSize = sizes[2];
   updateGarment();
 }
 if (key == '4') {
   currSize = sizes[3];
   updateGarment();
 }
 if (key == '5') {
   currSize = sizes[4];
   updateGarment();
 }
 if (key == '6') {
   currSize = sizes[5];
   updateGarment();
 }
}


