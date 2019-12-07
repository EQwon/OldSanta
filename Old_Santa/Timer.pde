class Timer
{
  boolean set = false;
  int savedTime;
  int interval;
  
  Timer(int _interval)
  {
    set = false;
    interval = _interval;
  }
  
  void startTimer()
  {
    savedTime = millis();
    set = true;
  }
  
  boolean isSet()
  {
    if(set) return true;
    else return false;
  }
  
  boolean isFinished()
  {
    int timePassed = millis() - savedTime;
    
    if(timePassed >= interval)
    {
      set = false;
      return true;
    }
    else return false;
  }
}
