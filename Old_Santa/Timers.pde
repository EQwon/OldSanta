class Timers
{
  Timers()
  {}
  
  Timer tutoFinishTimer = new Timer(4999);
  Timer correctReactionTimer = new Timer(1000);
  Timer wrongReactionTimer = new Timer(1000);
  Timer nextQuizTimer = new Timer(2000);
  Timer mainTimer = new Timer(1000);
  
  void checkTimers()
  {
    if(tutoFinishTimer.isSet() && tutoFinishTimer.isFinished())
    {
      stage = 3;
    }
    
    if(correctReactionTimer.isSet() && correctReactionTimer.isFinished())
    {
      CorrectReaction();
    }
    
    if(wrongReactionTimer.isSet() && wrongReactionTimer.isFinished())
    {
      WrongReaction();
    }
    
    if(nextQuizTimer.isSet() && nextQuizTimer.isFinished())
    {
      NextQuiz();
    }
    
    if(mainTimer.isSet() && mainTimer.isFinished())
    {
      stage = 4;
    }
  }
}
