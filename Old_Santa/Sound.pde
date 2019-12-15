class Sound
{
  String[] soundNames = {"clop", "jingle_bell", "letter", "present_off", "present_on", 
    "right_answer", "wrong_answer", "wrong_answer_2"};
  SoundFile[] sounds;

  Sound()
  {
    LoadSounds();
  }

  void LoadSounds()
  {
    sounds = new SoundFile[soundNames.length];
    for (int i = 0; i < soundNames.length; i++)
    {
      String name = soundNames[i];
      //may be make error..
      sounds[i] = new SoundFile(Old_Santa.this, name + ".wav");
    }
  }

  SoundFile getSound(String name)
  {
    for (int i = 0; i < soundNames.length; i++)
    {
      if (soundNames[i] == name)
      {
        return sounds[i];
      }
    }

    print("Can't find sound file names "+ name);
    return null;
  }
}
