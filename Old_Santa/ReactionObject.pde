class ReactionObject
{
  boolean on;
  boolean isCorrect;
  PImage correctImg;
  PImage[] hearts = new PImage[4];
  PImage wrongImg;
  
  private PVector[] position = {new PVector(379, 529), new PVector(1082, 606), new PVector(1331, 454)};
  private PVector myPos;
  
  ReactionObject()
  {}
  
  void initialize()
  {
    on = false;
  }
  
  void startDraw(int pos, boolean isCorrect)
  {
    if(correctImg == null) getImage();
    
    on = true;
    myPos = position[pos];
    this.isCorrect = isCorrect;
  }
  
  void draw()
  {
    if(isCorrect)
    {
      imageMode(CORNER);
      image(correctImg, myPos.x, myPos.y);
    }
    else
    {
      imageMode(CORNER);
      image(wrongImg, myPos.x, myPos.y);
    }
  }
  
  void getImage()
  {
    correctImg = imgHolder.getImage("letter_thanks");
    hearts[0] = imgHolder.getImage("heart0");
    hearts[1] = imgHolder.getImage("heart1");
    hearts[2] = imgHolder.getImage("heart2");
    hearts[3] = imgHolder.getImage("heart3");
    wrongImg = imgHolder.getImage("letter_noThanks");
  }
}
