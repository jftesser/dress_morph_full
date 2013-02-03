class Garment {
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
 Boolean areSleevesShown = true;
 Boolean isPeplumShown = true;
 
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
 
 // pattern
 Pattern pattern;
 
 
 Garment(String _size) {
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
  
  pattern = new Pattern(nSize);
 }
 
 String makeFilename(String name) {
   String fn;
   fn = "objs/"+nSize+"_"+name+".obj";
   
   return fn;
 }
 
 // tween setters
 void setSkirtLength(float amt) { // 0-1, larger is longer
   tmSkirtFullLength.setVal(amt);
   tmSkirtNarrowLength.setVal(amt);
   tmSkirt.updateOnly();
 }
 
 float getSkirtLength() {
  return tmSkirtFullLength.tween_val; 
 }
 
 void setSkirtFullness(float amt) { // 0-1. larger is fuller
   tmSkirt.setVal(amt);
   setPeplumPoofiness(amt);
 }
 
 float getSkirtFullness() {
  return tmSkirt.tween_val; 
 }
 
 void setSkirtWaviness(float amt) { // 0-1, larger is wavier
   tmSkirtWavinessLong.setVal(amt);
   tmSkirtWavinessShort.setVal(amt);
   tmSkirtFullLength.updateOnly();
   tmSkirt.updateOnly();
 }
 
 float getSkirtWaviness() {
  return tmSkirtWavinessLong.tween_val; 
 }
 
 void setBodiceSharpness(float amt) { // 0-1, larger is toward boat/deep v
  tmBodiceBoatRound.setVal(1.0-amt);
  tmBodiceDeepVSweet.setVal(1.0-amt);
  tmBodice.updateOnly();
 }
 
 float getBodiceSharpness() {
  return tmBodiceBoatRound.tween_val; 
 }
 
 void setBodiceDepth(float amt) { // 0-1, larger is toward sweetheart/deep v
  tmBodice.setVal(amt);
 }
 
 float getBodiceDepth() {
  return tmBodice.tween_val; 
 }
 
 void setSleeveLength(float amt) { // 0-1, larger is longer
   tmSleeves.setVal(amt);
 }
 
 float getSleeveLength() {
  return tmSleeves.tween_val; 
 }
 
 void setSleevePoofiness(float amt) { // 0-1, larger is poofier
   tmSleevesShort.setVal(amt);
   tmSleevesLong.setVal(amt);
   tmSleeves.updateOnly();
 }
 
 
 float getSleevePoofiness() {
  return tmSleevesShort.tween_val; 
 }
 
 void setPeplumPoofiness(float amt) { // 0-1, larger is poofier, autocalled
   tmPeplum.setVal(amt);
 }
 
 float getPeplumPoofiness() {
  return tmPeplum.tween_val; 
 }
 
 void render() {
  tmBodice.render();
  tmSkirt.render();
  if (areSleevesShown) tmSleeves.render();
  if (isPeplumShown) tmPeplum.render(); 
 }
 

 void toggleSleeves() {
   areSleevesShown = !areSleevesShown;
 }

 void togglePeplum() {
  isPeplumShown = !isPeplumShown;
 }
 
 void syncPattern() {
  pattern.setSkirtFullness(getSkirtFullness());
  pattern.setSkirtLength(getSkirtLength());
  pattern.setSkirtWaviness(getSkirtWaviness());

  pattern.setBodiceSharpness(getBodiceSharpness());
  pattern.setBodiceDepth(getBodiceDepth());

  pattern.setSleeveLength(getSleeveLength());
  pattern.setSleevePoofiness(getSleevePoofiness()); 
  
  pattern.isPeplumShown = isPeplumShown;
  pattern.areSleevesShown = areSleevesShown;
 }
 
 void savePattern() {
  syncPattern();
  pattern.save(); 
 }
  
}
