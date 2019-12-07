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
