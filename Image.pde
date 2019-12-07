class Image
{
  String[] imageNames = {"Background", "Rudolf", "Correct", "Wrong", "letter1",
          "present_earmuffs", "present_mittens", "present_money", "present_pengsoo", "present_pororo","present_woolen_hat"};
  PImage[] imgs;
  
  Image()
  {
    LoadImages();
  }
  
  void LoadImages()
  {
    imgs = new PImage[imageNames.length];
    for(int i = 0 ; i < imageNames.length; i++)
    {
      String name = imageNames[i];
      imgs[i] = loadImage(name + ".png");
    }
  }
  
  PImage getImage(String name)
  {
    for(int i = 0 ; i < imageNames.length; i++)
    {
      if(imageNames[i] == name)
      {
        return imgs[i];
      }
    }
    
    print("Can't find image names "+ name);
    return null;
  }
}
