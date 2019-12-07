class Data
{
  Data()
  {
  }
  
  String[][] QuizData = {
    //letter, answer, wrong1, wrong2
    {"present_earmuffs", "present_earmuffs", "present_mittens", "present_woolen_hat"},
    {"present_money", "present_money", "present_pengsoo", "present_pororo"},
    {"present_pororo", "present_pororo", "present_mittens", "present_woolen_hat"}
  };
  
  String[] randomData()
  {
    int ran = (int)random(QuizData.length);
    return QuizData[ran];
  }
}
