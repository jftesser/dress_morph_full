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

float displaceY=0;


void setup() {
  size(800, 600, OPENGL);
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
  currSize.setSkirtFullness(0.5);
  currSize.setSkirtLength(0.5);
  currSize.setSkirtWaviness(0.5);
  
  currSize.setBodiceSharpness(0.5);
  currSize.setBodiceDepth(0.5);
  
  currSize.setSleeveLength(0.5);
  currSize.setSleevePoofiness(0.5);
  smooth();
}

void draw() {
  background(250);
  stroke(0);
  lights();
  translate(width/2, height/2+displaceY, 0);
  rotateX(PI);
  //rotateX(mouseY*0.01);
  rotateY(PI);
  //gfx.origin(new Vec3D(),200);
  //noStroke();
  //gfx.mesh(mesh,false,10);

  //strokeWeight(3);
  scale(.5);
  //noFill();

  //displaceY = map(mouseY, 0, height, 0, 70);

  //lerpAmt= map(mouseY, height, 0, 0, 1);
  //column_num = floor(map(mouseX, 0, width, 0, tween));

fill(200);
currSize.render();
  //columns[column_num].render(lerpAmt);
  //highs.render(float(column_num)/20);
  //println(float(column_num)/20);
  //flats.render(lerpAmt);
  //shoe.render(lerpAmt);
}

void keyPressed() {
 if (key == 's') {
  currSize.savePattern();
 } 
}


