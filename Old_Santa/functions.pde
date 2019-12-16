void flip(PImage cam) {
  PImage buffer = new PImage(cam.width, cam.height);
  for (int i=0; i<cam.pixels.length; i++) {
    buffer.pixels[i] = cam.pixels[i];
  }
  for (int x=0; x<cam.width; x++) {
    for (int y=0; y<cam.height; y++) {
      cam.pixels[y*cam.width+x] = buffer.pixels[y*cam.width+(cam.width-x-1)];
    }
  }
}

void colorDetect(ArrayList<Blob> cb) {
  for (int x = 0; x < video.width; x++) {
    for (int y = 0; y < video.height; y++) {
      int loc = x + y * video.width;

      color currentColor = video.pixels[loc];
      float redity = red(currentColor) - 0.5*(blue(currentColor) + green(currentColor));
      //float bluty = blue(currentColor) - 0.5*(red(currentColor) + green(currentColor));

      if (redity > threshold) {
        boolean found = false;
        for (Blob b : cb) {
          if (b.isNear(x, y)) {
            b.add(x, y);
            found = true;
            break;
          }
        }
        if (!found) {
          Blob b = new Blob(x, y);
          cb.add(b);
        }
      }
    }
  }
}

void blobMatch(ArrayList<Blob> blobs, ArrayList<Blob> currentBlobs) {
  // There are no Blobs
  if (blobs.isEmpty() && currentBlobs.size() > 0) {
    for (Blob b : currentBlobs) {
      b.id = blobCounter%2;
      blobs.add(b);
      blobCounter++;
    }
  } else if (blobs.size() <= currentBlobs.size()) {
    //Match whatever blobs you can match
    for (Blob b : blobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob cb : currentBlobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !cb.taken) {
          recordD = d;
          matched = cb;
        }
      }
      matched.taken = true;
      b.become(matched);
    }
    //whatever is leftover make new blobs
    for (Blob b : currentBlobs) {
      if (!b.taken) {
        b.id = blobCounter%2;
        blobs.add(b);
        blobCounter++;
      }
    }
  } else if (blobs.size() > currentBlobs.size()) {

    for (Blob b : blobs) {
      b.taken = false;
    }

    for (Blob cb : currentBlobs) {
      float recordD = 1000;
      Blob matched = null;
      for (Blob b : blobs) {
        PVector centerB = b.getCenter();
        PVector centerCB = cb.getCenter();
        float d = PVector.dist(centerB, centerCB);
        if (d < recordD && !b.taken) {
          recordD = d;
          matched = b;
        }
      }
      if (matched != null) {
        matched.taken = true;
        matched.lifespan = maxLife;
        matched.become(cb);
      }
    }

    //Blob lifespan
    for (int i = blobs.size() - 1; i >=0; i--) {
      Blob b = blobs.get(i);
      if (!b.taken) {
        if (b.checkLife()) {
          blobs.remove(i);
        }
      }
    }
  }
}

//instead mouse pointer
PVector getMiddle(Blob a, Blob b) {
  PVector aCenter = a.getCenter();
  PVector bCenter = b.getCenter();

  float x = (aCenter.x + bCenter.x) * 0.5;
  float y = (aCenter.y + bCenter.y) * 0.5;
  return new PVector(x, y);
}

boolean hoverCheck(Present present, ArrayList<Blob> b) {
  for (int i = 0; i < b.size() - 1; i++) {
    for (int j = i + 1; j <b.size(); j++) {    
      if (dist(b.get(i).minx, b.get(i).miny, present.nowPos.x, present.nowPos.y) <= 75 
        && dist(b.get(j).maxx, b.get(j).maxy, present.nowPos.x, present.nowPos.y) <= 75) {
        return true;
      }
    }
  }
  return false;
}

ArrayList<Blob> blobSizeCheck(ArrayList<Blob> b)
{
  for (int i = b.size()-1; i >= 0; i--)
  {
    if (b.get(i).size() < 1200 || b.get(i).size() > 40000)
      b.remove(i);
  }

  if (b.size() < 2) return b;

  ArrayList<Blob> nowBlobs = new ArrayList<Blob>();

  int biggestIndex = 0;
  for (int i = 0; i < b.size(); i++)
  {
    if (b.get(i).size() > b.get(biggestIndex).size())
      biggestIndex = i;
  }
  nowBlobs.add(b.get(biggestIndex));
  b.remove(biggestIndex);

  biggestIndex = 0;
  for (int i = 0; i < b.size(); i++)
  {
    if (b.get(i).size() > b.get(biggestIndex).size())
      biggestIndex = i;
  }
  nowBlobs.add(b.get(biggestIndex));

  return nowBlobs;
}

boolean blobSizeComp(Blob a, Blob b)
{
  if (a.size() > b.size()) return true;
  else return false;
}


boolean checkBlobDist()
{
  ArrayList<Blob> b = blobs;
  if (b.size() < 2) return false;

  midPoint = videoMapping(getMiddle(b.get(0), b.get(1)));
  PVector distance = videoMapping(new PVector(b.get(0).getCenter().x - b.get(1).getCenter().x, b.get(0).getCenter().y - b.get(1).getCenter().y));

  if (distance.mag() < 700) return true;
  return false;
}

float distSq(float x1, float y1, float x2, float y2) {
  float d = (x2-x1)*(x2-x1) + (y2-y1)*(y2-y1);
  return d;
}

void blobDetection()
{
  ArrayList<Blob> currentBlobs = new ArrayList<Blob>();

  colorDetect(currentBlobs);

  //matching blob
  blobMatch(blobs, currentBlobs);

  //blob Size Check
  blobs = blobSizeCheck(blobs);

  //Blob Show
  if (blobs.size() == 1) blobs.get(0).isRightHand = true;
  else if (blobs.size() == 2)
  {
    Blob blob0 = blobs.get(0);
    Blob blob1 = blobs.get(1);

    if (blob0.getCenter().x < blob1.getCenter().x)
    {
      blob0.isRightHand = false;
      blob1.isRightHand = true;
    } else
    {
      blob0.isRightHand = true;
      blob1.isRightHand = false;
    }
  }

  for (Blob b : blobs) b.show();  
}

int[] randomPresentPos()
{
  int[] posArray= new int[]{0, 1, 2};
  int rand = (int)random(6);
  switch(rand)
  {
  case 0: 
    posArray = new int[]{0, 1, 2};
    break;
  case 1:
    posArray = new int[]{0, 2, 1};
    break;
  case 2:
    posArray = new int[]{1, 0, 2};
    break;
  case 3:
    posArray = new int[]{1, 2, 0};
    break;
  case 4:
    posArray = new int[]{2, 0, 1};
    break;
  case 5:
    posArray = new int[]{2, 1, 0};
    break;
  }

  return posArray;
}

PVector videoMapping(PVector pos)
{
  float videoWidth = 640;
  float videoHeight = 480;

  return new PVector(pos.x * (width/videoWidth), pos.y * (height/videoHeight));
}

void showRemainTime()
{
  // show remain time
  int remainTime = timers.mainTimer.remainTime();
  PImage bar = imgHolder.getImage("ui_clock_bar_background");
  PImage icon = imgHolder.getImage("ui_clock_icon");
  float ratio = timers.mainTimer.passedRatio();
  
  imageMode(CENTER);
  tint(255, 100);
  image(bar, 1650, 60);
  rectMode(CENTER);
  noStroke();
  fill(255, 50, 50, 200);
  rect(1650 - bar.width*ratio/2, 60, (1-ratio)*bar.width, 0.9*bar.height);
  textAlign(CENTER, CENTER);
  fill(255);
  textSize(40);
  text(remainTime, width - 80, 60);
  tint(255);
  image(icon, 1400, 60);
}

void showCorrectCnt()
{
  PImage box = imgHolder.getImage("ui_score_box");
  PImage icon = imgHolder.getImage("ui_score_icon");
  
  imageMode(CENTER);
  tint(255, 100);
  image(box, 1200, 60);
  fill(255);
  textSize(40);
  textAlign(CENTER, CENTER);
  text(correctCnt, 1250, 60);
  tint(255);
  image(icon, 1100, 55);
}
