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
    if(set == false) return 0;
    
    int remain = savedTime + interval - millis();
    
    return remain/1000;
  }
  
  float passedRatio()
  {
    float interval = this.interval;
    float passedTime = millis() - savedTime;
    
    return passedTime / interval;
  }
}
