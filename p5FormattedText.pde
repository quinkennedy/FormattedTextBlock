PFont regular, bold;
FormattedTextBlock bt;

void setup(){
  size(400, 400);
  noLoop();
  String out = "";
  for(int i = 0; i < PFont.list().length; i++){
    out += PFont.list()[i] + ", ";
  }
  println(out);
  regular = createFont("Liberation Serif", 14);
  bold = createFont("Liberation Serif Bold", 14);
  
  FormattedTextBlock.FormattedText[] text = {
    new FormattedTextBlock.FormattedText("some text ", regular),
    new FormattedTextBlock.FormattedText("that sucks", bold),
    new FormattedTextBlock.FormattedText(" and some other text ", regular),
    new FormattedTextBlock.FormattedText("that also sux", bold)};
  bt = new FormattedTextBlock(text, 300, createGraphics(width, height));
  println(bt.toString());
}

void draw(){
  background(180);
  textFont(regular);
  noFill();
  stroke(255);
  rect(0, 0, 300, 300);
  fill(0);
  drawBlockedText();
  text("some text that sucks and some other text that also sux", 10, 100);
  //text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac venenatis nisl. Ut a fermentum elit, sit amet tristique purus. Mauris et maximus nulla. Aenean a blandit erat, vitae consequat lacus. Phasellus quis sapien in diam accumsan bibendum sed sed risus. Nam ipsum nisi, viverra et metus ut, rhoncus maximus orci. Mauris placerat tellus metus, ut imperdiet tortor vulputate vel. Nam leo erat, rhoncus vel dolor a, pulvinar interdum quam. Maecenas euismod interdum ullamcorper. Suspendisse vestibulum nibh et lacus rutrum imperdiet. Phasellus et pretium sapien. Sed commodo nulla at euismod suscipit. Praesent gravida tincidunt neque sit amet vestibulum. ",
  //0, 0, 300, 300);
}

void drawBlockedText(){
  FormattedTextBlock.FormattedLine currLine;
  float currX = 0, currY = 20;
  ArrayList<FormattedTextBlock.FormattedLine> lines = bt.lines;
  for(int i = 0; i < lines.size(); i++){
    currLine = bt.lines.get(i);
    for(int w = 0; w < currLine.texts.size(); w++){
      FormattedTextBlock.FormattedText currContig = currLine.texts.get(w);
      textFont(currContig.font);
      text(currContig.text, currX, currY);
      currX += textWidth(currContig.text);
      println(currX);
    }
    currY += 20;
    currX = 0;
  }
}