class TutoText
{
  boolean on;
  String text;
  PImage[] imgs = new PImage[5];

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
    if (presents[2].isDelivering)
    {
      imageMode(CENTER);
      image(imgHolder.getImage("t5"), 205, 137);
      if(imgs[0] == null)
      {
        getImage();
        timers.tutoFinishTimer.startTimer();
      }      
      showTutoFinishTimer(); 
      return;
    }

    if (blobs.size() < 2)
    {
      imageMode(CENTER);
      image(imgHolder.getImage("t2"), 205, 137);
      /*fill(255);
       textAlign(CENTER, CENTER);
       textSize(24);
       text("Pick up Controller", width/2, 50);*/
    } else
    {
      if (holdingPresentNum == 0)
      {
        imageMode(CENTER);
        image(imgHolder.getImage("t3"), 205, 137);        
        /*fill(255);
         textAlign(CENTER, CENTER);
         textSize(24);
         text("GOOD!", width/2, 50);
         text("NOW Pick up Present!", width/2, 100);*/
      } else
      {
        imageMode(CENTER);
        image(imgHolder.getImage("t4"), 205, 137);
        /*fill(255);
         textAlign(CENTER, CENTER);
         textSize(24);
         text("VERY GOOD!", width/2, 50);
         text("NOW Carry Present", width/2, 100);*/
      }
    }
  }

  void showTutoFinishTimer()
  {
    int time = timers.tutoFinishTimer.remainTime();
    PImage img = imgs[time];

    imageMode(CENTER);
    image(img, width/2, height/2);
  }

  void getImage()
  {
    imgs[0] = imgHolder.getImage("number_1");
    imgs[1] = imgHolder.getImage("number_2");
    imgs[2] = imgHolder.getImage("number_3");
    imgs[3] = imgHolder.getImage("number_4");
    imgs[4] = imgHolder.getImage("number_5");
  }
}
