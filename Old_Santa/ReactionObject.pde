class ReactionObject
{
  boolean on;
  boolean isCorrect;
  PImage correctImg;
  PImage[] hearts = new PImage[4];
  PImage wrongImg;
  
  private PVector[] position = new PVector[3];
  private PVector myPos;
  
  ReactionObject()
  {}
  
  void initialize()
  {
    on = false;
    position[0] = new PVector(0.197*width, 0.49*height);
    position[1] = new PVector(0.563*width, 0.561*height);
    position[2] = new PVector(0.693*width, 0.42*height);
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
      
      PImage heart = animators.correctReactionAnim.anim();
      image(heart, myPos.x + correctImg.width/2, myPos.y - heart.height);
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
    wrongImg = imgHolder.getImage("letter_noThanks");
  }
}
