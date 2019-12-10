class TutoText
{
  boolean on;
  String text;

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
      timers.tutoFinishTimer.startTimer();
      fill(0);
      textAlign(CENTER, CENTER);
      textSize(500);
      text(timers.tutoFinishTimer.remainTime(), width/2, height/2);      
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
}
