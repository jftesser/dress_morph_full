void mousePressed() {
  if (bodicebutton.ifOver()){
    bodicebutton.setState(true);
    skirtbutton.setState(false);
    editmode=1;
  }
  if (skirtbutton.ifOver()){
    skirtbutton.setState(true);
    bodicebutton.setState(false);
    editmode=2;
  }
  if (sleevebutton.ifOver()){
    sleevebutton.toggleState();
    skirtbutton.setState(false);
    bodicebutton.setState(false);
    currSize.toggleSleeves();
    editmode=3;
  }
  if (peplumbutton.ifOver()){
    peplumbutton.toggleState();
    skirtbutton.setState(false);
    bodicebutton.setState(false);
    currSize.togglePeplum();
  }
  if (sizebutton.ifOver()){
    sizebutton.toggleState();
    if(sizebutton.active) {
      openSizePanel();
    } else {
      closeSizePanel();
    }
  }
  if (diybutton.ifOver()){
    diybutton.toggleState();
    if(diybutton.active) {
      openDiyPanel();
    } else {
      closeDiyPanel();
    }
  }
  if (buybutton.ifOver()){
    buybutton.toggleState();
    if(buybutton.active) {
      openBuyPanel();
    } else {
      closeBuyPanel();
    }
  }
  
  if (black_render.ifOver()) {
    black_render.setState(true);
    wireframe_render.setState(false);
    showWireframe = false;
  }
  if (wireframe_render.ifOver()) {
    black_render.setState(false);
    wireframe_render.setState(true);
    showWireframe = true;
  }
  
}

void mouseDragged() {
  
  if (mouseY > 780) {
    if (mouseX-pmouseX >0) {
      rotatetarget-=10;
    } else {
      rotatetarget+=10;
    }
   } 
   if (mouseY<780) {
    if (mouseX-pmouseX >0) {
      if (editmode == 2) {
        if (targetSkirtFullness< 1) {
          targetSkirtFullness+=0.02;
        }
      }
      if (editmode == 1) {
        if (BodiceSharpness< 1) {
          BodiceSharpness+=0.015;
        }
      }
      if (editmode == 3) {
        if (SleevePoofiness< 1) {
          SleevePoofiness+=0.01;
        }
      }
      
    } else {
      if (editmode == 2) {
        if (targetSkirtFullness> 0) {
          targetSkirtFullness-=0.02;
        }
      }
      if (editmode == 1) {
        if (BodiceSharpness> 0) {
          BodiceSharpness-=0.015;
        }
      }
      if (editmode == 3) {
        if (SleevePoofiness> 0) {
          SleevePoofiness-=0.01;
        }
      }
    }
    
    if (mouseY-pmouseY >0) {      
      if (editmode == 2) {
        if (targetSkirtLength< 1) {
          targetSkirtLength+=0.02;
        }
      }
      if (editmode == 1) {
        if (BodiceDepth< 1) {
          BodiceDepth+=0.01;
        }
      }
      if (editmode == 3) {
        if (SleeveLength< 1) {
          SleeveLength+=0.01;
        }
      }
      
    } 
    if (mouseY-pmouseY<0) {
      if (editmode == 2) {
        if (targetSkirtLength> 0) {
          targetSkirtLength-=0.02;
        }
      }
      if (editmode == 1) {
        if (BodiceDepth> 0) {
          BodiceDepth-=0.01;
        }
      }
      if (editmode == 3) {
        if (SleeveLength> 0) {
          SleeveLength-=0.01;
        }
      }
      
    }
    
  }
  
}
