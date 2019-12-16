class Present
{
  boolean on;
  boolean isDelivering;
  boolean isFalling;
  PImage img;
  PVector originPos;
  PVector nowPos;
  int myNum;
  int width, height;

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
    originPos = new PVector(1500, 272 + 320*posNum);
    nowPos = originPos;
    this.img = quiz.presentImage(myNum);
    this.width = img.width;
    this.height = img.height;
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

      if (nowPos.y > 1200) backToOrigin();
    } else nowSpeed = 0;

    carriageChecking();

    /*if (inputState == 0) backToOrigin();
     else*/    if (inputState == 1) assignSelf(); 
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

      soundHolder.getSound("clop").loop();
      soundHolder.getSound("jingle_bell").play();

      for (Present p : presents)
      {
        if (p == this) continue;
        p.poofAnim();
      }

      if (stage != 3) return; 
      if (answerNum == myNum) { 
        timers.correctReactionTimer.startTimer();
        soundHolder.getSound("right_answer_bell").play();
        soundHolder.getSound("right_answer").play();
      } else {
        timers.wrongReactionTimer.startTimer();
        soundHolder.getSound("wrong_answer").play();
        soundHolder.getSound("wrong_answer_2").play();
      }
    } else {
      soundHolder.getSound("clop").stop();
    }
  }

  void assignSelf()
  {
    if (nowPos.x - width/2 <= midPoint.x && midPoint.x <= nowPos.x + width/2
      && nowPos.y - height/2 <= midPoint.y && midPoint.y <= nowPos.y + height/2)
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
    nowPos = originPos;

    nowSpeed = 0;
    isFalling = false;
  }
}
