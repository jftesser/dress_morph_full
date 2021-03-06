class Pattern {
 // this is the upper level class that holds all the other tweens
 // a garment has a size, and must also have various tween values
 
 String nSize;
 
 // part names
 // BODICE
 String nBodiceBoat = "bodiceboat";
 String nBodiceDeepV = "bodicedeepv";
 String nBodiceRound = "bodiceround";
 String nBodiceSweetheart = "bodicesweetheart";
 
 // SKIRT
 String nSkirtLongFull = "skirtlongfull";
 String nSkirtLongFullWavy = "skirtlongfullwavy";
 String nSkirtLongNarrow = "skirtlongnarrow";
 String nSkirtShortFull = "skirtshortfull";
 String nSkirtShortFullWavy = "shirtshortfullwavy";
 String nSkirtShortNarrow = "skirtshortnarrow";
 
 // SLEEVES
 String nSleevesShort = "sleevesshortpoofy";
 String nSleevesLong = "sleeveslong";
 String nSleevesShortPoofy = "sleevesshortpoofy";
 String nSleevesLongPoofy = "sleeveslongpoofy";

 // PEPLUM 
 String nPeplumFull = "peplumfull";
 String nPeplumTight = "peplumtight"; 
 
 // show flags
 Boolean areSleevesShown = false;
 Boolean isPeplumShown = false;
 
 // meshes
 // BODICE
 TweenMesh tmBodiceBoatRound;
 TweenMesh tmBodiceDeepVSweet;
 TweenMesh tmBodice;
 
 // SKIRT
 TweenMesh tmSkirtWavinessLong;
 TweenMesh tmSkirtWavinessShort;
 TweenMesh tmSkirtFullLength;
 TweenMesh tmSkirtNarrowLength;
 TweenMesh tmSkirt;
 
 // SLEEVES
 TweenMesh tmSleevesShort;
 TweenMesh tmSleevesLong;
 TweenMesh tmSleeves;

 // PEPLUM 
 TweenMesh tmPeplum;
 
 
 Pattern(String _size) {
  nSize = _size;
  
  // load tween meshes from files
  tmBodiceBoatRound = new TweenMesh(makeFilename(nBodiceBoat),makeFilename(nBodiceRound));
  tmBodiceDeepVSweet = new TweenMesh(makeFilename(nBodiceDeepV),makeFilename(nBodiceSweetheart));
  tmBodice = new TweenMesh(tmBodiceBoatRound,tmBodiceDeepVSweet);
  
  tmSkirtWavinessLong = new TweenMesh(makeFilename(nSkirtLongFull),makeFilename(nSkirtLongFullWavy));
  tmSkirtWavinessShort = new TweenMesh(makeFilename(nSkirtShortFull),makeFilename(nSkirtShortFullWavy));
  tmSkirtFullLength = new TweenMesh(tmSkirtWavinessShort,tmSkirtWavinessLong);
  tmSkirtNarrowLength = new TweenMesh(makeFilename(nSkirtShortNarrow),makeFilename(nSkirtLongNarrow));
  tmSkirt = new TweenMesh(tmSkirtNarrowLength,tmSkirtFullLength);
  
  tmSleevesShort = new TweenMesh(makeFilename(nSleevesShort),makeFilename(nSleevesShortPoofy));
  tmSleevesLong = new TweenMesh(makeFilename(nSleevesLong),makeFilename(nSleevesLongPoofy));
  tmSleeves = new TweenMesh(tmSleevesShort,tmSleevesLong);
  
  tmPeplum = new TweenMesh(makeFilename(nPeplumTight),makeFilename(nPeplumFull));
  
  
 }
 
 String makeFilename(String name) {
   String fn;
   fn = "objs/"+nSize+"_"+name+"_2D.obj";
   
   return fn;
 }
 
 // tween setters
 void setSkirtLength(float amt) { // 0-1, larger is longer
   tmSkirtFullLength.setVal(amt);
   tmSkirtNarrowLength.setVal(amt);
   tmSkirt.updateOnly();
 }
 
 void setSkirtFullness(float amt) { // 0-1. larger is fuller
   tmSkirt.setVal(amt);
   setPeplumPoofiness(amt);
 }
 
 void setSkirtWaviness(float amt) { // 0-1, larger is wavier
   tmSkirtWavinessLong.setVal(amt);
   tmSkirtWavinessShort.setVal(amt);
   tmSkirtFullLength.updateOnly();
   tmSkirt.updateOnly();
 }
 
 void setBodiceSharpness(float amt) { // 0-1, larger is toward boat/deep v
  tmBodiceBoatRound.setVal(1.0-amt);
  tmBodiceDeepVSweet.setVal(1.0-amt);
  tmBodice.updateOnly();
 }
 
 void setBodiceDepth(float amt) { // 0-1, larger is toward sweetheart/deep v
  tmBodice.setVal(amt);
 }
 
 void setSleeveLength(float amt) { // 0-1, larger is longer
   tmSleeves.setVal(amt);
 }
 
 void setSleevePoofiness(float amt) { // 0-1, larger is poofier
   tmSleevesShort.setVal(amt);
   tmSleevesLong.setVal(amt);
   tmSleeves.updateOnly();
 }
 
 void setPeplumPoofiness(float amt) { // 0-1, larger is poofier, autocalled
   tmPeplum.setVal(amt);
 }
 
 void render() {
  tmBodice.render();
  tmSkirt.render();
  if (areSleevesShown) tmSleeves.render();
  if (isPeplumShown) tmPeplum.render(); 
 }
 
 void save() {
   //1mm = 2.83464567pts
   //1in = 72 pts
   
   String folder = year()+"-"+month()+"-"+day()+"-"+hour()+"-"+minute()+"-"+second();
   
   tmBodice.save("bodice",folder);
   tmSkirt.save("skirt",folder);
   if (areSleevesShown) tmSleeves.save("sleeves",folder);
   if (isPeplumShown) tmPeplum.save("peplum",folder); 
 }
 
 void toggleSleeves() {
   areSleevesShown = !areSleevesShown;
 }
  
}
