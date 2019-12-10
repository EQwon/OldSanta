class Present
{
  boolean on;
  boolean isDelivering;
  PImage img;
  PVector originPos;
  PVector nowPos;
  int myNum;
  int width, height;

  Present(int num)
  {
    myNum = num + 1;
  }

  void initialize(int posNum)
  {
    on = true;
    isDelivering = false;
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

    if (inputState == 0) backToOrigin();
    else if (inputState == 1) assignSelf(); 
    else if (inputState == 2) drag(new PVector(midPoint.x, midPoint.y));
    else releasePresent();
  }

  void assignSelf()
  {
    if (nowPos.x - width/2 <= midPoint.x && midPoint.x <= nowPos.x + width/2
      && nowPos.y - height/2 <= midPoint.y && midPoint.y <= nowPos.y + height/2)
    {
      holdingPresentNum = myNum;
    }
  }

  void drag(PVector dragPos)
  {
    if (holdingPresentNum != myNum) return;
    if (isDelivering) return;
    nowPos = dragPos;
  }

  void releasePresent()
  {
    //print(holdingPresentNum);
    //println(", " + myNum + ", ");
    if (holdingPresentNum != myNum) return;
    if (car.isPresentOn())
    {
      print("answer is " + answerNum);
      isDelivering = true;
      for (int i = 0; i < presents.length; i++)
      {
        if (i+1 == holdingPresentNum) continue;
        presents[i].poofAnim();
      }
      car.deliver = true;
      letter.on = false;
      if (stage != 3) return; 
      if (answerNum == myNum) timers.correctReactionTimer.startTimer();
      else timers.wrongReactionTimer.startTimer();
    }
    holdingPresentNum = 0;
  }

  void poofAnim()
  {
    on = false;
  }

  void backToOrigin()
  {
    nowPos = originPos;
  }
}
