class Data
{
  Data()
  {
  }
  
  String[][] QuizData = {
    //letter, answer, wrong1, wrong2
    {"letter_elsas_clothes", "elsas_clothes", "glass_shoes", "money"},
    {"letter_glasses", "glasses", "ear_phone", "hamster_doll"},
    {"letter_rubber_boots", "rubber_boots", "umbrella", "fire_engine"}
  };
  
  String[] randomData()
  {
    int ran = (int)random(QuizData.length);
    return QuizData[ran];
  }
}
