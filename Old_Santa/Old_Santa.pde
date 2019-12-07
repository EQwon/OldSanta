import processing.video.*;

Capture video;
Image imgHolder;

Carriage car = new Carriage();
Quiz quiz;
Letter letter = new Letter();
Present[] presents = {new Present(0), new Present(1), new Present(2)};
Data data = new Data();
Timers timers = new Timers();

int holdingPresentNum = 0;
int correctCnt = 0;
int answerNum = 2;

//Blob tracking setting
ArrayList<Blob> blobs = new ArrayList<Blob>();
color trackColor = color(255, 0, 0);
float threshold = 70;
float distThreshold = 15;
int maxLife = 200;
int blobCounter = 0;
// midPoint is a mouse position
PVector midPoint = new PVector(0, 0);

//Input
boolean pclick = false;
boolean click = false;
// 0 : free, 1 : just Pressed, 2 : pressing, 3: just released
int inputState = 0;

//Stage & System
int stage = 0;
int score = 0;
int synopsis = 0; // PImage[] index num
int time = 30;
boolean tutorialClear = false;
boolean tutoHoverCheck = false;

void setup()
{
  size(640, 480);

  imgHolder = new Image();

  // video setting
  video = new Capture(this, 640, 480, 30);
  video.start();

  NextQuiz();
}

void draw()
{
  switch(stage) {
  case 0: //start screen
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Start Screen", width/2, height/2);
    textSize(24);
    text("- Press ANY Key -", width/2, height/2+40);
    break;

  case 1: //Synopsis screen
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Synopsis Screen " + synopsis, width/2, height/2);
    textSize(24);
    text("- Press SpaceBar -", width/2, height/2+40);    
    break;

  case 2: //tutorial
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

    if (blobs.size() < 2 && !click) {    
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("Pick up Controller", width/2, 50);
    } else if(!click || !tutoHoverCheck) {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("GOOD!", width/2, 50);
      text("NOW Pick up Present!", width/2, 100);
    } else if(click && tutoHoverCheck) {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(24);
      text("VERY GOOD!", width/2, 50);
      text("NOW Carry Present", width/2, 100);
    } 

    blobDetection();
    
    if(tutorialClear) stage = 3;
    break;

  case 3: //intermission
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("PRESS SPACEBAR FOR PLAY", width/2, height/2);
    break;

  case 4: //main game
    blobStateMachine();
    timers.checkTimers();

    if (video.available())
    {
      video.read();
      flip(video);
    }
    video.loadPixels();

    drawBackground();
    if (letter.on) letter.draw();
    for (int i = 0; i < presents.length; i++)
    {
      if (presents[i].on) presents[i].draw();
    }
    if (car.on) car.draw();

    blobDetection();
    break;

  case 5: //result
    background(255);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(40);
    text("Result Screen" + synopsis, width/2, height/2);
    textSize(24);
    text("Your Score " + score, width/2, height/2+40);
    break;
  }
}

void drawBackground()
{
  background(255);
  imageMode(CENTER);
  image(imgHolder.getImage("Background"), width/2, height/2);
}

void NextQuiz()
{
  quiz = new Quiz(data.randomData());

  letter.initialize();
  for (int i = 0; i < presents.length; i++)
    presents[i].initialize();
  car.initialize();
}

void CorrectReaction()
{
  println("Correct!");
  correctCnt += 1;
  letter.on = true;
  letter.img = imgHolder.getImage("Correct");

  timers.nextQuizTimer.startTimer();
}

void WrongReaction()
{
  println("Wrong");
  letter.on = true;
  letter.img = imgHolder.getImage("Wrong");

  timers.nextQuizTimer.startTimer();
}

void blobStateMachine()
{
  // When blob distance is smaller than const value,
  // it means "Click"
  click = checkBlobDist();

  if (click) {
    if (pclick == false) inputState = 1;
    else inputState = 2;
  } else {
    if (pclick == true) inputState = 3;
    else inputState = 0;
  }

  pclick = click;
}

void keyPressed() {
  if (stage == 0) {
    stage = 1;
  } else if (stage == 1) {
    if (key == ' ') {
      synopsis++;
    }
    if (synopsis > 4) {
      stage = 2;
    }
  } else if (stage == 3 && key == ' ') {
    stage = 4;
  } else if (stage == 5 && (key == 'r' || key == 'R')) {
    stage = 0;
    score = 0;
    time = 30;
    synopsis = 0;
    tutorialClear = false;
  }
}
