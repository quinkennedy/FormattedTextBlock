import processing.core.PFont;
import processing.core.PGraphics;
import java.util.ArrayList;

public class FormattedTextBlock{ //<>//
  FormattedText[] text;
  int maxWidth;
  ArrayList<FormattedLine> lines;
  
  public FormattedTextBlock(FormattedText[] text, int maxWidth, PGraphics pg){
    this.text = text;
    this.maxWidth = maxWidth;
    calculateLines(pg);
  }
  
  //split the formatted text into separate lines of text
  //based on computed text lengths and given maximum text block width
  private void calculateLines(PGraphics pg){
    //TODO:
    // - Split on newlines
    // - calculate x/y pos of each line
    //   - pay attention to textHeight/textAscent/textDescent
    //all the lines
    lines = new ArrayList<FormattedLine>();
    //the current line we are populating
    FormattedLine line = newLine(lines);
    //the width of the FormattedText text that has 
    //been committed to the current line
    float currWidth = 0;
    //the current text that can concatenate on the current line
    //but has not yet been committed
    String contig = "";
    //activate PGraphics element so we can query it 
    //for text widths
    pg.beginDraw();
    
    //for each formatted text element
    for(int ti = 0; ti < text.length; ti++){
      FormattedText currT = text[ti];
      //set the PGraphics font for accurate width calculation
      pg.textFont(currT.font);
      //DEBUG
      System.out.println(currT.toString());
      System.out.println(currT.font);
      
      //split the formatted text into words
      SplitText[] words = currT.split();
      //for each word
      for(int wi = 0; wi < words.length; wi++){
        SplitText currW = words[wi];
        //get the width of the uncommitted text along with
        //the current word we are testing
        //TODO: understand the difference between unseen separators (spaces)
        // and seen separators (hyphens)
        float contigWidth = pg.textWidth(contig + currW.text);
        float contigNsepWidth = pg.textWidth(contig + currW.toString());
        //DEBUG
        System.out.println(contigWidth +" " + contigNsepWidth);
        
        //if the word doesn't fit
        if (currWidth + contigWidth > maxWidth){
          if (currWidth == 0 && contig.length() == 0){
            //one word alone on the line
            line.add(new FormattedText(currW.toString(), currT.font));
            line = newLine(lines);
            continue;
          } else if (contig.length() > 0){
            //there is un-committed text
            line.add(new FormattedText(contig, currT.font));
            contig = currW.toString();
            line = newLine(lines);
            currWidth = 0;
          } else {
            //I guess this line is full & fully committed
            contig = currW.toString();
            line = newLine(lines);
            currWidth = 0;
          }
        } else {
          //word does fit
          contig += currW.toString();
        }
      }
      //end of current FormattedText element
      //commit any uncommitted text
      if (contig.length() > 0){
        line.add(new FormattedText(contig, currT.font));
        currWidth += pg.textWidth(contig);
        contig = "";
      }
    }
    //finished using this PGraphics element
    pg.endDraw();
  }
  
  private FormattedLine newLine(ArrayList<FormattedLine> lines){
    FormattedLine fresh = new FormattedLine();
    lines.add(fresh);
    return fresh;
  }
  
  public String toString(){
    String output = "[BLOCKED TEXT]\n";
    for(int i = 0; i < text.length; i++){
      output += text[i].toString() + "\n";
    }
    return output;
  }
  
  public static class FormattedText{
    String text;
    PFont font;
    float startX, startY;
    
    public FormattedText(String text, PFont font){
      this.text = text;
      this.font = font;
    }
    
    public SplitText[] split(){
      String restText = text;
      int i;
      char[] splitGlyphs = {' '};
      ArrayList<SplitText> sText = new ArrayList<SplitText>();
      
      do{
        i = indexOf(restText, splitGlyphs);
        if (i == -1){
          sText.add(new SplitText(restText, ""));
        } else {
          String item = restText.substring(0, i);//startIndex, endIndex
          String sep = restText.substring(i, i+1);
          restText = restText.substring(i + 1);
          sText.add(new SplitText(item, sep));
        }
      }while(i >= 0 && restText.length() > 0);
      
      return sText.toArray(new SplitText[sText.size()]);
    }
    
    private int indexOf(String s, char[] glyphs){
      int lowestIndex = -1;
      int currIndex;
      for(int i=0; i < glyphs.length; i++){
        currIndex = s.indexOf(glyphs[i]);
        if (currIndex == -1){
          continue;
        } else if (lowestIndex == -1 || currIndex < lowestIndex){
          lowestIndex = currIndex;
        }
      }
      return lowestIndex;
    }
    
    public void setPos(int startX, int startY){
      this.startX = startX;
      this.startY = startY;
    }
    
    public String toString(){
      String output =  font.getName() + ":" + text;
      return output;
    }
  }
  
  public static class SplitText{
    String postSep;
    String text;
    
    public SplitText(String t, String pSep){
      postSep = pSep;
      text = t;
    }
    
    public String toString(){
      return text+postSep;
    }
  }
  
  public static class FormattedLine{
    ArrayList<FormattedText> texts = new ArrayList<FormattedText>();
    
    public void add(FormattedText text){
      texts.add(text);
    }
  }
}