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
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  bt = new FormattedTextBlock(text, 300, pg);
  pg.endDraw();
  println(bt.toString());
}

void draw(){
  background(180);
  drawBlockedText();
  text("some text that sucks and some other text that also sux", 10, 100);
  //text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce ac venenatis nisl. Ut a fermentum elit, sit amet tristique purus. Mauris et maximus nulla. Aenean a blandit erat, vitae consequat lacus. Phasellus quis sapien in diam accumsan bibendum sed sed risus. Nam ipsum nisi, viverra et metus ut, rhoncus maximus orci. Mauris placerat tellus metus, ut imperdiet tortor vulputate vel. Nam leo erat, rhoncus vel dolor a, pulvinar interdum quam. Maecenas euismod interdum ullamcorper. Suspendisse vestibulum nibh et lacus rutrum imperdiet. Phasellus et pretium sapien. Sed commodo nulla at euismod suscipit. Praesent gravida tincidunt neque sit amet vestibulum. ",
  //0, 0, 300, 300);
}

void drawBlockedText(){
  pushMatrix();
  translate(10, 10);
  textFont(regular);
  noFill();
  stroke(255);
  rect(0, 0, 300, 300);
  stroke(0);
  noFill();
  rect(0, 0, bt.maxWidth, bt.totalHeight);
  noStroke();
  fill(0);
  bt.render(g);
  popMatrix();
}