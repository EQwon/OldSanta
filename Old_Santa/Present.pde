class Present
{
  boolean on;
  boolean isDelivering;
  boolean isFalling;
  PImage img;
  PVector originPos;
  PVector nowPos;
  int myNum;
  int myWidth, myHeight;

  float nowSpeed = 0;
  float gravity = 3;

  Present(int num)
  {
    myNum = num + 1;
  }

  void initialize(int posNum)
  {
    on = true;
    isDelivering = false;
    isFalling = false;
    originPos = new PVector(0.78*width, (0.252+0.296*posNum)*height);
    nowPos = originPos;
    this.img = quiz.presentImage(myNum);
    this.myWidth = img.width;
    this.myHeight = img.height;
  }

  void initialize(PVector pos)
  {
    on = true;
    isDelivering = false;
    isFalling = false;
    originPos = pos;
    nowPos = originPos;
    this.img = quiz.presentImage("tutorial_gift");
    this.myWidth = img.width;
    this.myHeight = img.height;
  }

  void draw()
  {
    if (img == null) return;

    imageMode(CENTER);
    image(img, nowPos.x, nowPos.y);
    if (isDelivering)
    {
      nowPos = new PVector(nowPos.x + car.speed, nowPos.y);
      return;
    }
    if (isFalling)
    {
      nowPos.y += nowSpeed;
      nowSpeed += gravity;

      if (nowPos.y > height + 100) backToOrigin();
    } else nowSpeed = 0;

    carriageChecking();

    if (inputState == 1) assignSelf(); 
    else if (inputState == 2) drag(new PVector(midPoint.x, midPoint.y));
    else if (inputState == 3) releasePresent();
  }

  void carriageChecking()
  {
    if (car.isPresentOn(this))
    {
      isDelivering = true;
      car.deliver = true;
      letter.on = false;

      soundHolder.getSound("clop").play();
      soundHolder.getSound("jingle_bell").play();

      for (Present p : presents)
      {
        if (p == this) continue;
        p.poofAnim();
      }

      if (stage != 3) return; 
      if (answerNum == myNum) { 
        timers.correctReactionTimer.startTimer();
      } else {
        timers.wrongReactionTimer.startTimer();
      }
    }
  }

  void assignSelf()
  {
    if (nowPos.x - myWidth/2 <= midPoint.x && midPoint.x <= nowPos.x + myWidth/2
      && nowPos.y - myHeight/2 <= midPoint.y && midPoint.y <= nowPos.y + myHeight/2)
    {
      holdingPresentNum = myNum;
      soundHolder.getSound("present_on").play();
    }
  }

  void drag(PVector dragPos)
  {
    if (holdingPresentNum != myNum) return;
    if (isDelivering) return;
    nowPos = dragPos;
    nowSpeed = 0;
  }

  void releasePresent()
  {
    if (holdingPresentNum != myNum) return;

    isFalling = true;
    holdingPresentNum = 0;
    soundHolder.getSound("present_off").play();
  }

  void poofAnim()
  {
    on = false;
  }

  void backToOrigin()
  {
    println("Back to Origin");
    nowPos = originPos;

    nowSpeed = 0;
    isFalling = false;
  }
}
