import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:word_hurdle/wordle.dart';
import 'package:english_words/english_words.dart' as words;

class Appprovider extends ChangeNotifier{
  List<String> totalwords=[];         //the total list of words of 5letters the game has
  List<String> rowinputs=[];
  List<String> excludedletter=[];     //excluded letters
  List<Wordle> board=[];              //the bubbbles
  final random = Random.secure();     //random num
  String answer = '';                //the answer word
  int count=0;
  int index=0;
  final lettersperrow=5;
  bool wins =false;
  final totalattempts=6;
  int attempts=0;



  init(){
    totalwords=words.all.where((element)=>element.length==5).toList();
    generateboard();
    generateword();
  } //makes the list of words of 5letters

  generateboard(){
    board=List.generate(30, (index)=>Wordle(letter: ''),);
  } //put the values to the bubbles ,value ''

  generateword(){
    answer=totalwords[random.nextInt(totalwords.length)].toUpperCase();
    print(answer);
    // print('hi');
  }

  bool get isvalid => totalwords.contains(rowinputs.join('').toLowerCase());

  bool get shouldcheckans => rowinputs.length==lettersperrow;

  bool get noattempsleft => attempts==totalattempts;

  inputLetter(String letter){
    if(count<lettersperrow) {
      rowinputs.add(letter);
      count++;
      board[index]=Wordle(letter: letter);
      index++;
      // print(rowinputs);
      notifyListeners();
    }
  }

  void deleteletter() {
    if(rowinputs.isNotEmpty){
      rowinputs.removeAt(rowinputs.length-1);
      // print(rowinputs);
      notifyListeners();
    }
    if(count>0){
      board[index-1]=Wordle(letter: '');
      count--;
      index--;
      notifyListeners();
    }
  }

  void checkans() {
    final input =rowinputs.join('');
    if(answer==input){
      wins=true;
    }
    else{
      _markletter();
      if(attempts<totalattempts){
        _gotonextrow();
      }
    }
  }

  void _markletter() {
    for(int i=0;i<board.length;i++){
      if(board[i].letter.isNotEmpty && answer.contains(board[i].letter)){
        board[i].exists=true;
      }
      else if(board[i].letter.isNotEmpty && !answer.contains(board[i].letter)){
        board[i].doesnotexist=true;
        excludedletter.add(board[i].letter);
      }
    }
    notifyListeners();
  }

  void _gotonextrow() {
    attempts++;
    count= 0;
    rowinputs.clear();
  }

  reset(){
    count=0;
    index=0;
    rowinputs.clear();
    board.clear();
    excludedletter.clear();
    attempts=0;
    wins=false;
    answer='';
    generateboard();
    generateword();
    notifyListeners();
  }
}