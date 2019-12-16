void titleScene()
{
  imageMode(CENTER);
  image(imgHolder.getImage("Title1"), width/2, height/2);
}

void introScene()
{
  background(255);
  fill(0);

  String imgName = "";
  switch(synopsis)
  {
  case 0:
    imgName = "intro0";
    break;
  case 1:
    imgName = "intro1";
    break;
  case 2:
    imgName = "intro2";
    break;
  case 3:
    imgName = "intro3";
    break;
  case 4:
    imgName = "intro4";
    break;
  }
  imageMode(CENTER);
  image(imgHolder.getImage(imgName), width/2, height/2);
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
  if (reaction.on) reaction.draw();

  blobDetection();
}

void endingScene()
{
  PImage ending;
  
  if(correctCnt >= 6)
  {
    
  }
  else
  {
    ending = imgHolder.getImage("ending_sad");
    ending.resize(width, height);
    
    PVector textPos = new PVector(width * 0.2f, height * 0.1f);
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(40);
    text(str(correctCnt), textPos.x, textPos.y);
  }
}
