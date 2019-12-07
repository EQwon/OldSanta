class Carriage
{
  boolean on;
  PVector drawPos;
  PVector collPos;
  PVector collSize;
  boolean deliver = false;
  float speed = 20;
  PImage rudolfImg;

  Carriage()
  {
    initialize();
  }
  
  void initialize()
  {
    on = true;
    drawPos = new PVector(210, 369);
    collPos = new PVector(180, 400);
    collSize = new PVector(120, 100);
    deliver = false;
  }

  void draw()
  {
    drawCarriage();
    if(deliver)
      drawPos = new PVector(drawPos.x + speed, drawPos.y);
    else
      drawCollideBox();
  }

  void drawCarriage()
  {
    if(rudolfImg == null)
    {
      rudolfImg = imgHolder.getImage("Rudolf");
    }
    imageMode(CENTER);
    image(rudolfImg, drawPos.x, drawPos.y);
  }

  void drawCollideBox()
  {
    stroke(255, 255, 0);
    noFill();
    rectMode(CENTER);
    rect(collPos.x, collPos.y, collSize.x, collSize.y);
  }

  boolean isPresentOn()
  {
    if (holdingPresentNum == 0) return false;
    if (!(collPos.x - collSize.x/2 <= midPoint.x && midPoint.x <= collPos.x + collSize.x/2
      && collPos.y - collSize.y/2 <= midPoint.y && midPoint.y <= collPos.y + collSize.y/2)) return false;
    
    return true;
  }
}
