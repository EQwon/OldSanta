class Letter
{
  boolean on;
  PImage img;
  PVector pos = new PVector(200, 200);

  Letter()
  {
  }

  void draw()
  {
    if (img == null) return;
    
    imageMode(CORNER);
    image(img, pos.x, pos.y);
  }

  void initialize()
  {
    on = true;
    img = quiz.letterImage();
    img.resize(660, 450);
  }
}
