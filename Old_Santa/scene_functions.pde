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

  if (synopsis == 4) {
    drawBackground();
    imageMode(CENTER);
    image(imgHolder.getImage("t1"), 205, 137);
  }
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
  if (tutoText.on) tutoText.draw();
  if (presents[2].on) presents[2].draw();
  if (car.on) car.draw();

  blobDetection();
}

void mainScene()
{
  if (timers.mainTimer.isSet() == false)
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
    showRemainTime();
    showCorrectCnt();
  }
  if (letter.on) letter.draw();
  for (int i = 0; i < presents.length; i++)
  {
    if (presents[i].on) presents[i].draw();
  }
  if (car.on) car.draw();

  blobDetection();
}
