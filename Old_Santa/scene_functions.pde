void titleScene()
{
  PImage bg = animators.backgroundAnim.anim();
  bg.resize(width, height);
  
  imageMode(CENTER);
  image(bg, width/2, height/2);
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
  
  PImage target = imgHolder.getImage(imgName);
  target.resize(width, height);
  imageMode(CENTER);
  image(target, width/2, height/2);
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
    ending = animators.goodEndingAnim.anim();
    ending.resize(width, height);
    imageMode(CENTER);
    image(ending, width/2, height/2);
    
    PVector textPos = new PVector(width * 0.73f, height * 0.134f);
    fill(127, 19, 19);
    textAlign(CENTER, CENTER);
    textSize(0.083*width);
    text(str(correctCnt), textPos.x, textPos.y);
  }
  else
  {
    ending = imgHolder.getImage("ending_sad");
    ending.resize(width, height);
    imageMode(CENTER);
    image(ending, width/2, height/2);
    
    PVector textPos = new PVector(width * 0.32f, height * 0.136f);
    fill(127, 19, 19);
    textAlign(CENTER, CENTER);
    textSize(0.036*width);
    text(str(correctCnt), textPos.x, textPos.y);
  }
}
