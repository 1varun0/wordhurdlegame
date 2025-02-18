import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:word_hurdle/wordle.dart';

class WordleView extends StatelessWidget {
  final Wordle wordle;

  const WordleView({super.key, required this.wordle});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: wordle.exists
            ? Colors.white60
            : wordle.doesnotexist
                ? Colors.blueGrey.shade700
                : null,
        border: Border.all(
          color: Colors.amber,
          width: 1.5,
        ),
      ),
      child: Text(
        wordle.letter,
        style: TextStyle(
          color: wordle.exists
              ? Colors.black
              : wordle.doesnotexist
                  ? Colors.white54
                  : Colors.white,
        ),
      ),
    );
  }
}
