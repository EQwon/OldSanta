class Timers
{
  Timers()
  {}
  
  Timer correctReactionTimer = new Timer(1000);
  Timer wrongReactionTimer = new Timer(1000);
  Timer nextQuizTimer = new Timer(2000);
  
  void checkTimers()
  {
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
  }
}
