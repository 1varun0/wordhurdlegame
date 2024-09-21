class Wordle {      //bubble
  String letter;
  bool exists;
  bool doesnotexist;

  Wordle({
    required this.letter,
    this.doesnotexist = false,
    this.exists = false,
  });
}
