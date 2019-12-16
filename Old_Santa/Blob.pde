class Blob {
  float minx;
  float miny;
  float maxx;
  float maxy;

  int id = 0;

  boolean isRightHand;
  boolean taken = false;
  PImage rightHand;
  PImage leftHand;

  int lifespan = maxLife;

  Blob(float x, float y) {
    minx = x;
    miny = y;
    maxx = x;
    maxy = y;
  }

  boolean checkLife() {
    lifespan--;
    if (lifespan < 0) {
      return true;
    } else {
      return false;
    }
  }

  void add(float x, float y) {
    minx = min(minx, x);
    miny = min(miny, y);
    maxx = max(maxx, x);
    maxy = max(maxy, y);
  }

  void show()
  {
    PVector drawPos = videoMapping(getCenter());

    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CENTER);
    if (isRightHand) showRightHand(drawPos);
    else showLeftHand(drawPos);
  }

  void show(Blob b, PImage img) {
    image(img, b.minx, b.miny, b.maxx-b.minx, b.maxy-b.miny);
  }

  void become(Blob other) {
    minx = other.minx;
    maxx = other.maxx;
    miny = other.miny;
    maxy = other.maxy;
  }

  float size() {
    return (maxx-minx) * (maxy-miny);
  }

  PVector getCenter() {
    float x = (maxx - minx) * 0.5 + minx;
    float y = (maxy - miny) * 0.5 + miny;

    return new PVector(x, y);
  }

  boolean isNear(float x, float y) {
    float cx = max(min(x, maxx), minx);
    float cy = max(min(y, maxy), miny);
    float d = distSq(cx, cy, x, y); 

    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }

  void showRightHand(PVector drawPos)
  {
    if (rightHand == null) rightHand = imgHolder.getImage("glove_right");

    imageMode(CENTER);
    image(rightHand, drawPos.x - 120, drawPos.y);
  }

  void showLeftHand(PVector drawPos)
  {
    if (leftHand == null) leftHand = imgHolder.getImage("glove_left");

    imageMode(CENTER);
    image(leftHand, drawPos.x + 120, drawPos.y);
  }
}
