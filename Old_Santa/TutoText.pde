class TutoText
{
  boolean on;
  String text;
  PImage[] tutoImgs = new PImage[5];
  PImage[] numberImgs = new PImage[5];

  TutoText()
  {
    on = true;
  }

  void offTutoText()
  {
    on = false;
  }

  void draw()
  {
    if (tutoImgs[0] == null) getTutoImage();

    if (presents[2].isDelivering)
    {
      // Well done
      imageMode(CENTER);
      image(tutoImgs[4], width/2, height/2);
      if (numberImgs[0] == null)
      {
        getNumberImage();
        timers.tutoFinishTimer.startTimer();
      }
      showTutoFinishTimer(); 
      return;
    }
    if (presents[2].nowPos.x <= width * 0.3f)
    {
      // Let's drop
      imageMode(CENTER);
      image(tutoImgs[3], width/2, height/2);
      return;
    }
    if (blobs.size() < 2)
    {
      // Ready
      imageMode(CENTER);
      image(tutoImgs[0], width/2, height/2);
    } else
    {
      if (holdingPresentNum == 0)
      {
        // Let's grab
        imageMode(CENTER);
        image(tutoImgs[1], width/2, height/2);
      } else
      {
        // Let's deliver
        imageMode(CENTER);
        image(tutoImgs[2], width/2, height/2);
      }
    }
  }

  void showTutoFinishTimer()
  {
    int time = timers.tutoFinishTimer.remainTime();
    PImage img = numberImgs[time];

    imageMode(CENTER);
    image(img, width/2, height/2);
  }

  void getTutoImage()
  {
    tutoImgs[0] = imgHolder.getImage("t1");
    tutoImgs[1] = imgHolder.getImage("t2");
    tutoImgs[2] = imgHolder.getImage("t3");
    tutoImgs[3] = imgHolder.getImage("t4");
    tutoImgs[4] = imgHolder.getImage("t5");

    for (int i = 0; i < tutoImgs.length; i++)
    {
      tutoImgs[i].resize(width, height);
    }
  }

  void getNumberImage()
  {
    numberImgs[0] = imgHolder.getImage("number_1");
    numberImgs[1] = imgHolder.getImage("number_2");
    numberImgs[2] = imgHolder.getImage("number_3");
    numberImgs[3] = imgHolder.getImage("number_4");
    numberImgs[4] = imgHolder.getImage("number_5");
  }
}
