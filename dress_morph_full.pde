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
float rotateval=100;
float rotatetarget = 180;

 float SkirtFullness=0.3;
 float targetSkirtFullness=0.5;
 float SkirtLength=0.4;
 float targetSkirtLength=.6;
  
 float BodiceSharpness=0.5;
 float BodiceDepth=0.5;
  
 float SleeveLength=0.5;
 float SleevePoofiness=0.5;

boolean showWireframe = false;
int editmode = 2; //start with the skirt

void init() {
  // trick to make it possible to change the frame properties
  frame.removeNotify(); 
  // comment this out to turn OS chrome back on
  frame.setUndecorated(true); 
  // comment this out to not have the window "float"
  frame.setAlwaysOnTop(true); 
  //frame.setResizable(true);  
  frame.addNotify(); 

  super.init();
}

void setup() {
  size(768, 1024, OPENGL);
  gfx=new ToxiclibsSupport(this);

sizes = new Garment[6];
sizes[0] = new Garment("2");
sizes[1] = new Garment("4");
sizes[2] = new Garment("6");
sizes[3] = new Garment("8");
sizes[4] = new Garment("10");
sizes[5] = new Garment("12");

currSize = sizes[0];
// test stuff
  updateGarment();
  smooth();
}

void draw() {
  background(250);
  
  lights();
  translate(width/2, displaceY, 0);
  rotateX(PI);
  rotateY(rotateval*PI/180);

  if (showWireframe) {
    stroke(0);
    fill(255,255,255,200);
  } else {
    fill(55);
    noStroke();
  }

  scale(.6);

  //lerpAmt= map(mouseY, height, 0, 0, 1);
  //column_num = floor(map(mouseX, 0, width, 0, tween));

currSize.render();
  //columns[column_num].render(lerpAmt);
  //highs.render(float(column_num)/20);
  //println(float(column_num)/20);
  //flats.render(lerpAmt);
  //shoe.render(lerpAmt);
  
  rotateval = tween(rotatetarget, rotateval, .01);
  SkirtFullness = tween(targetSkirtFullness, SkirtFullness, .04);
  SkirtLength = tween(targetSkirtLength, SkirtLength, .04);
  updateGarment();
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
 if (key == 's') {
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
 }
 if (key == '5') {
   currSize = sizes[4];
 }
 if (key == '6') {
   currSize = sizes[5];
 }
}


