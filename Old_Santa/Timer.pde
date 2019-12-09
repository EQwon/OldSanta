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
    if(set) return;
    
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
  
  int remainTime()
  {
    int remain = savedTime + interval - millis();
    
    return remain/1000;
  }
}
