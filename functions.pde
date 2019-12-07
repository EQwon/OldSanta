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

void blobSizeCheck(ArrayList<Blob> b, int size) { 
  for (int i = b.size()-1; i >= 0; i--) {
    if (b.get(i).size() < size) {
      b.remove(i);
    }
  }
}


boolean checkBlobDist()
{
  ArrayList<Blob> b = blobs;
  for (int i = 0; i < b.size() - 1; i++) {
    for (int j = i + 1; j <b.size(); j++) {
      midPoint = getMiddle(b.get(i), b.get(j));
      if (dist(b.get(i).minx, b.get(i).miny, b.get(j).maxx, b.get(j).maxy) <= 150) {
        return true;
      }
    }
  }
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
  blobSizeCheck(currentBlobs, 500);
  blobSizeCheck(blobs, 500);

  //Blob Show
  for (Blob b : blobs) b.show();

  //debug
  textAlign(RIGHT);
  textSize(12);
  fill(0);
  text("check Dist : " + checkBlobDist(), width-10, 30);
  //text("check hover : " + hoverCheck(present, blobs), width-10, 50);
  text("Middle Point x : " + midPoint.x, width-10, 70);
  text("Middle Point y : " + midPoint.y, width-10, 90);
  text("Blob State : " + inputState, width-10, 110);
  text("Is Click : " + click, width-10, 130);
  text("Was Clicked : " + pclick, width-10, 150);
}
