void mouseDragged() {
  
  if (mouseY > 780) {
    println(mouseY);
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
          BodiceSharpness+=0.01;
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
          BodiceSharpness-=0.01;
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
