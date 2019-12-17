class Letter
{
  boolean on;
  PImage img;
  PVector pos;

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
    pos = new PVector(0.1*width, 0.185*height);
    img = quiz.letterImage();
    img.resize(660, 450);
  }
}
