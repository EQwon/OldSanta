class Quiz
{
  int answer;
  String[] imgNames;

  Quiz(String[] imgNames)
  {
    answer = 1;
    this.imgNames = imgNames;

    answerNum = this.answer;
  }
  PImage letterImage()
  {
    return imgHolder.getImage(imgNames[0]);
  }
  
  PImage presentImage(int num)
  {
    return imgHolder.getImage(imgNames[num]);
  }
  
  PImage presentImage(String name)
  {
    return imgHolder.getImage(name);
  }
}
