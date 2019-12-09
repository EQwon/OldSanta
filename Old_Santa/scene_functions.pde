void startScene()
{
  background(255);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Start Screen", width/2, height/2);
  textSize(24);
  text("- Press ANY Key -", width/2, height/2+40);
}

void synopsisScene()
{
  background(255);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Synopsis Screen " + synopsis, width/2, height/2);
  textSize(24);
  text("- Press SpaceBar -", width/2, height/2+40);
}

void tutorialScene()
{
  blobStateMachine();
  timers.checkTimers();

  if (video.available())
  {
    video.read();
    flip(video);
  }
  video.loadPixels();

  drawBackground();
  if (presents[2].on) presents[2].draw();
  if (car.on) car.draw();
  if (tutoText.on) tutoText.draw();

  blobDetection();
}

void mainScene()
{
  if(timers.mainTimer.isSet() == false)
  {
    timers.mainTimer.startTimer();
    NextQuiz();
  }
  
  blobStateMachine();
  timers.checkTimers();

  if (video.available())
  {
    video.read();
    flip(video);
  }
  video.loadPixels();

  drawBackground();
  if (timers.mainTimer.remainTime() >= 0)
  {
    // show remain time
    int remainTime = timers.mainTimer.remainTime();

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(24);
    text(remainTime + " Sec", 0.7 * width, 50);
    text(correctCnt + " Success", 0.5 * width, 50);
  }
  if (letter.on) letter.draw();
  for (int i = 0; i < presents.length; i++)
  {
    if (presents[i].on) presents[i].draw();
  }
  if (car.on) car.draw();

  blobDetection();
}
