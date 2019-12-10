class Data
{
  Data()
  {
  }
  
  String[][] QuizData = {
    //letter, answer, wrong1, wrong2
    {"letter_elsas_clothes", "elsas_clothes", "glass_shoes", "money"},
    {"letter_glasses", "glasses", "ear_phone", "hamster_doll"},
    {"letter_rubber_boots", "rubber_boots", "umbrella", "fire_engine"},
    {"letter_soccerBall", "soccerBall", "gugu", "train"},
    {"letter_train", "train", "teddy_bear", "umbrella"},
    {"letter_fish", "fish", "rose", "santas_hat"},
    {"letter_kisses", "kisses", "zzinGoguma", "rose"},
    {"letter_soap", "soap", "sneakers", "pocky"},
    {"letter_watch", "watch", "ringtoy", "pengsoo"},
    {"letter_walet", "walet", "balloon", "mail_box"}
  };
  
  String[] randomData()
  {
    int ran = (int)random(QuizData.length);
    return QuizData[ran];
  }
}
