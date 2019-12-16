import processing.video.*;
import processing.sound.*;

Capture video;
Image imgHolder;
Sound soundHolder;

//Main System
TutoText tutoText = new TutoText();
Carriage car = new Carriage();
ReactionObject reaction = new ReactionObject();
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
float distThreshold = 10;
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
int synopsis = 0; // PImage[] index num

void setup()
{
  fullScreen();

  imgHolder = new Image();
  soundHolder = new Sound();

  // video setting
  video = new Capture(this, 640, 480, 30);
  video.start();
}

void draw()
{
  switch(stage) {
  case 0: //start screen
    titleScene();
    break;

  case 1: //Synopsis screen
    introScene();
    break;

  case 2: //tutorial
    tutorialScene();
    break;

  case 3: //main game
    mainScene();
    break;

  case 4: //result
    endingScene();
    break;
  }
}

void drawBackground()
{
  background(255);
  imageMode(CENTER);

  PImage image = imgHolder.getImage("Background");
  image(image, width/2, height/2);
}

void NextQuiz()
{
  holdingPresentNum = 0;

  quiz = new Quiz(data.randomData());

  letter.initialize();
  soundHolder.getSound("letter").play();
  int[] presentPos = randomPresentPos();
  for (int i = 0; i < presents.length; i++)
  {
    presents[i].initialize(presentPos[i]);
  }
  car.initialize();
  reaction.initialize();
}

void TutoQuiz()
{
  holdingPresentNum = 0;

  quiz = new Quiz(data.randomData());

  letter.initialize();
  soundHolder.getSound("letter").play();
  presents[2].initialize(new PVector(1250, 850));
  car.initialize();
  reaction.initialize();
}

void CorrectReaction()
{
  println("Correct!");
  soundHolder.getSound("right_answer_bell").play();
  soundHolder.getSound("right_answer").play();
  correctCnt += 1;
  reaction.startDraw((int)random(3), true);

  timers.nextQuizTimer.startTimer();
}

void WrongReaction()
{
  println("Wrong");
  soundHolder.getSound("wrong_answer").play();
  soundHolder.getSound("wrong_answer_2").play();
  reaction.startDraw((int)random(3), false);

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
    if (key == ' ') {
      stage = 1;
      soundHolder.getSound("paper").play();
    }
  } else if (stage == 1) {
    if (key == ' ')
    {
      synopsis++;
      if (synopsis <= 4) {
        soundHolder.getSound("paper").play();
      }
      if (synopsis >= 5)
      {
        synopsis = 4;
        stage = 2;
        TutoQuiz();
      }
    }
  } else if (stage == 2 && key == 'a')
  {
    stage = 3;
  } else if (stage == 4 && (key == 'r' || key == 'R')) {
    stage = 0;
    correctCnt = 0;
    synopsis = 0;
  }
}
