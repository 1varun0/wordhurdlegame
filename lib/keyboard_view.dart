import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const keylist = [
  [
    'Q',
    'W',
    'E',
    'R',
    'T',
    'Y',
    'U',
    'I',
    'O',
    'P',
  ],
  [
    'A',
    'S',
    'D',
    'F',
    'G',
    'H',
    'J',
    'K',
    'L',
  ],
  [
    'Z',
    'X',
    'C',
    'V',
    'B',
    'N',
    'M',
  ],
];

class KeyboardView extends StatelessWidget {
  final List<String> excludedLetters;
  final Function(String) onPressed;

  const KeyboardView({
    super.key,
    required this.excludedLetters,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: [
            for (int i = 0; i < keylist.length; i++)
              Row(
                children: keylist[i]
                    .map(
                      (a) => Virtualkey(
                        letter: a,
                        excluded: excludedLetters.contains(a),
                        onPress: (value) {
                          onPressed(value);
                        },
                      ),
                    )
                    .toList(),
              ),
          ],
        ),
      ),
    );
  }
}

class Virtualkey extends StatelessWidget {
  final String letter;
  final bool excluded;
  final Function(String) onPress;

  const Virtualkey({
    super.key,
    required this.letter,
    required this.excluded,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          onPress(letter);
        },
        child: Text(letter),
        style: ElevatedButton.styleFrom(
          backgroundColor: excluded ? Colors.red : Colors.black,
          foregroundColor: Colors.white,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
