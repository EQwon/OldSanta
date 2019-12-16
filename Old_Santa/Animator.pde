class Animator
{
  PImage[] imgs;
  int nowImgNum;

  Animator(PImage[] sprites, int delay)
  {
    imgs = new PImage[sprites.length * delay];
    
    for (int i = 0; i < sprites.length; i++)
    {
      for(int j = 0 ; j < delay; j++)
      {
        imgs[i * delay + j] = sprites[i];
      }
    }
    this.nowImgNum = 0;
  }

  PImage anim()
  {
    nowImgNum += 1;
    if(nowImgNum >= imgs.length)
      nowImgNum = 0;
    
    return imgs[nowImgNum];
  }
}
