class Animators
{
  boolean isSet;

  Animator backgroundAnim;
  Animator correctReactionAnim;
  Animator goodEndingAnim;

  Animators()
  {
    isSet = false;
  }

  void initialize()
  {
    if (isSet) return;

    PImage[] bgAnims = {imgHolder.getImage("title1"), imgHolder.getImage("title2")};
    PImage[] correctAnims = {imgHolder.getImage("heart0"), imgHolder.getImage("heart1"), imgHolder.getImage("heart2"), imgHolder.getImage("heart3")};
    PImage[] goodEndingAnims = {imgHolder.getImage("ending_good1"), imgHolder.getImage("ending_good2")};

    backgroundAnim = new Animator(bgAnims, 15);
    correctReactionAnim = new Animator(correctAnims, 5);
    goodEndingAnim = new Animator(goodEndingAnims, 3);
  }
}
