class Blob{
  float minx;
  float miny;
  float maxx;
  float maxy;
    
  int id = 0;

  boolean taken = false;

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

  void show() {
    stroke(0);
    fill(255);
    strokeWeight(2);
    rectMode(CORNERS);
    rect(minx, miny, maxx, maxy);
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
    
    //float d = width*height;
    //for (PVector v : points) {
    //  float tempD =distSq(x,y,v.x,v.y);
    //  if(tempD < d) {
    //    d = tempD;
    //  }
    //}
    
    if (d < distThreshold*distThreshold) {
      return true;
    } else {
      return false;
    }
  }
}
