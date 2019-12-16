class Data
{
  String[][] randomData = new String[21][4];
  int dataNum;
  
  Data()
  {
  }
  
  String[][] QuizData = {
    //letter, answer, wrong1, wrong2
    {"letter_christmas_tree", "christmas_tree", "teddy_bear", "scarf"},
    {"letter_cozy_socks", "cozy_socks", "teddy_bear", "santas_hat"},
    {"letter_elsas_clothes", "elsas_clothes", "glass_shoes", "money"},
    {"letter_fire_engine", "fire_engine", "police_car", "christmas_tree"},
    {"letter_fish", "fish", "rose", "santas_hat"},
    {"letter_glasses", "glasses", "ear_phone", "hamster_doll"},
    {"letter_globe", "globe", "binoculars", "mimis_phone"},
    {"letter_hamster_doll", "hamster_doll", "cat_headband", "fish"},
    {"letter_kisses", "kisses", "zzinGoguma", "rose"},
    {"letter_mittens", "mittens", "woolen_hat", "earmuffs"},
    {"letter_piggy_bank", "piggy_bank", "money", "pengsoo"},
    {"letter_puzzle", "puzzle", "lego", "drawer"},
    {"letter_red_bag", "red_bag", "crocodile_doll", "elsas_clothes"},
    {"letter_rubber_boots", "rubber_boots", "umbrella", "fire_engine"},
    {"letter_smartphone", "smartphone", "camera_kid", "glass_shoes"},
    {"letter_soap", "soap", "sneakers", "pocky"},
    {"letter_soccerBall", "soccerBall", "gugu", "train"},
    {"letter_straw_hat", "straw_hat", "binoculars", "globe"},
    {"letter_train", "train", "teddy_bear", "umbrella"},
    {"letter_wallet", "wallet", "balloon", "mail_box"},
    {"letter_watch", "watch", "ringtoy", "pengsoo"}    
  };
  
  String[] randomData()
  {
    dataNum += 1;
    if(dataNum >= randomData.length)
    {
      dataNum = 0;
      randomizeData();
    }
    if(randomData[dataNum][0] == null)
      randomizeData();
    return randomData[dataNum];
  }
  
  void randomizeData()
  {
    randomData = QuizData;
    dataNum = 0;
    
    for(int i = 0 ; i < QuizData.length; i++)
    {
      int num = (int)random(QuizData.length);
      
      String[] temp = randomData[i];
      randomData[i] = randomData[num];
      randomData[num] = temp;
    }
  }
}
