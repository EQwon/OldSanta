class Image
{
  String[] imageNames = {"Background", "Rudolf", "Correct", "Wrong", 
    "letter_christmas_tree", "letter_cozy_socks", "letter_elsas_clothes", "letter_fire_engine", "letter_fish",
    "letter_glasses", "letter_globe", "letter_hamster_doll", "letter_kisses", "letter_mittens", 
    "letter_piggy_bank", "letter_puzzle", "letter_red_bag", "letter_rubber_boots", "letter_smartphone",
    "letter_soap", "letter_soccerBall", "letter_straw_hat", "letter_train", "letter_wallet",
    "letter_watch", 
    "balloon", "binoculars", "camera_kid", "cat_headband", "christmas_tree",
    "cozy_socks", "crocodile_doll", "digital_camera", "drawer", "ear_phone",
    "earmuffs", "elsas_clothes", "fire_engine", "fish", "glass_shoes",
    "glasses", "globe", "gugu", "hamster_doll", "kisses",
    "lego", "mail_box", "mimis_phone", "mittens", "money", 
    "pengsoo", "piggy_bank", "pocky", "police_car", "pororo",
    "puzzle", "red_bag", "ringtoy", "rose", "rubber_boots",
    "santas_hat", "scarf", "smartphone", "sneakers", "soap",
    "soccerBall", "straw_hat", "teddy_bear", "train", "umbrella",
    "wallet", "watch", "woolen_hat", "yankee_candle", "zzinGoguma",
    "intermission", "t1", "t2", "t3", "t4", "t5",
    "ui_clock_bar_background", "ui_clock_icon", "ui_score_box", "ui_score_icon"};
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
