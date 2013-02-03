void openSizePanel() {
  targetsizepanelx=0;
  closeBuyPanel();
  closeDiyPanel();
  diybutton.setState(false);
  buybutton.setState(false);
  targetdisplaceX = width/2 +60;
}

void closeSizePanel(){
  targetsizepanelx= -247;
  targetdisplaceX = width/2;
}

void openBuyPanel(){
  targetbuypanelx=768-307;
  closeSizePanel();
  closeDiyPanel();
  diybutton.setState(false);
  sizebutton.setState(false);
  targetdisplaceX = width/2 - 170;
}

void closeBuyPanel(){
  targetbuypanelx=769;
  targetdisplaceX = width/2;
}

void openDiyPanel() {
  closeSizePanel();
  closeBuyPanel();
  sizebutton.setState(false);
  buybutton.setState(false);
  showPattern = true;
}

void closeDiyPanel() {
  showPattern = false;
}
