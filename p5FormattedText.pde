PFont regular, bold;
FormattedTextBlock bt;
int margin = 10;
int bottomMargin = 40;
int updateDelayMs = 3000; //millis
int lastUpdate = -updateDelayMs;
String sourceText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. "+
"Fusce ac venenatis nisl. Ut a fermentum elit, sit amet tristique purus. "+
"Mauris et maximus nulla. Aenean a blandit erat, vitae consequat lacus. "+
"Phasellus quis sapien in diam accumsan bibendum sed sed risus. Nam ipsum "+
"nisi, viverra et metus ut, rhoncus maximus orci. Mauris placerat tellus "+
"metus, ut imperdiet tortor vulputate vel. Nam leo erat, rhoncus vel dolor "+
"a, pulvinar interdum quam. Maecenas euismod interdum ullamcorper. "+
"Suspendisse vestibulum nibh et lacus rutrum imperdiet. Phasellus et "+
"pretium sapien. Sed commodo nulla at euismod suscipit. Praesent gravida "+
"tincidunt neque sit amet vestibulum. ";

void setup(){
  size(400, 400);
  loadFonts();
}

void loadFonts(){
  String out = "";
  for(int i = 0; i < PFont.list().length; i++){
    out += PFont.list()[i] + ", ";
  }
  //println(out);
  regular = createFont("Liberation Serif", 200);
  bold = createFont("Liberation Serif Bold", 200);
}

FormattedTextBlock.FormattedText[] constructText(){
  ArrayList<FormattedTextBlock.FormattedText> text = 
    new ArrayList<FormattedTextBlock.FormattedText>();
  String[] splitText = sourceText.split(" ");
  int totalLength = (int)random(1, splitText.length + 1);
  PFont currFont = regular;
  for(int i = 0; i < totalLength; ){
    int currLength = (int)random(1, 10);
    String currText = "";
    for(int j = 0; j < currLength && i < totalLength; j++, i++){
      currText += splitText[i] + " ";
    }
    text.add(new FormattedTextBlock.FormattedText(currText, currFont));
    currFont = (currFont == regular ? bold : regular);
  }
  return text.toArray(new FormattedTextBlock.FormattedText[text.size()]);
}

void draw(){
  if (lastUpdate + updateDelayMs <= millis()){
    constructText();
    
    FormattedTextBlock.FormattedText[] text = constructText();
    PGraphics pg = createGraphics(width, height);
    pg.beginDraw();
    bt = new FormattedTextBlock(text, width-margin-margin, pg);
    bt.constrainHeight(height-margin-bottomMargin, pg);
    pg.endDraw();
    lastUpdate = millis();
  }
  background(180);
  fill(0);
  rect(0, 0, width * (1.0-((millis()-lastUpdate)/(float)updateDelayMs)), 5);
  drawBlockedText();
}

void drawBlockedText(){
  pushMatrix();
  translate(margin, margin);
  noStroke();
  fill(0);
  bt.render(g, true);
  popMatrix();
}