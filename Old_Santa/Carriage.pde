class Carriage
{
  boolean on;
  PVector drawPos;
  PVector collPos;
  PVector collSize;
  boolean deliver = false;
  float speed = 80;
  PImage rudolfImg;

  Carriage()
  {
    initialize();
  }

  void initialize()
  {
    on = true;
    drawPos = new PVector(-950, height - 350);
    collPos = new PVector(0.15*width, 0.95*height);
    collSize = new PVector(0.3*width, 0.1*height);
    deliver = false;
  }

  void draw()
  {
    drawCarriage();
    if (deliver)
    {
      drawPos = new PVector(drawPos.x + speed, drawPos.y);
    }
  }

  void drawCarriage()
  {
    if (rudolfImg == null)
    {
      rudolfImg = imgHolder.getImage("Rudolf");
    }

    imageMode(CORNER);
    image(rudolfImg, drawPos.x, drawPos.y);
  }

  void drawCollideBox()
  {
    stroke(255, 255, 0);
    noFill();
    rectMode(CENTER);
    rect(collPos.x, collPos.y, collSize.x, collSize.y);
  }

  boolean isPresentOn(Present p)
  {
    if (!(collPos.x - collSize.x/2 <= p.nowPos.x && p.nowPos.x <= collPos.x + collSize.x/2
      && collPos.y - collSize.y/2 <= p.nowPos.y && p.nowPos.y <= collPos.y + collSize.y/2)) return false;

    return true;
  }
}
