class Image
{
  String[] imageNames = {"Background", "Rudolf", "Correct", "Wrong", 
    "letter_elsas_clothes", "letter_glasses", "letter_rubber_boots", "letter5",
    "binoculars", "camera_kid", "cat_headband", "christmas_tree", "crocodile_doll", 
    "digital_camera", "drawer", "ear_phone", "earmuffs", "elsas_clothes",
    "fire_engine", "glass_shoes", "glasses", "globe", "hamster_doll",
    "lego", "mail_box", "mimis_phone", "mittens", "money",
    "pengsoo", "pocky", "police_car", "pororo", "puzzle",
    "red_bag", "rubber_boots", "straw_hat", "teddy_bear", "umbrella",
    "woolen_hat"};
  PImage[] imgs;

  Image()
  {
    LoadImages();
  }

  void LoadImages()
  {
    imgs = new PImage[imageNames.length];
    for (int i = 0; i < imageNames.length; i++)
    {
      String name = imageNames[i];
      imgs[i] = loadImage(name + ".png");
    }
  }

  PImage getImage(String name)
  {
    for (int i = 0; i < imageNames.length; i++)
    {
      if (imageNames[i] == name)
      {
        return imgs[i];
      }
    }

    print("Can't find image names "+ name);
    return null;
  }
}
