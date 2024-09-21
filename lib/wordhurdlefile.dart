import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:word_hurdle/helpfunctions.dart';
import 'package:word_hurdle/keyboard_view.dart';
import 'package:word_hurdle/wordhurdleprovider.dart';
import 'package:word_hurdle/wordle_view.dart';

class WordHurdlePage extends StatefulWidget {
  const WordHurdlePage({super.key});

  @override
  State<WordHurdlePage> createState() => _WordHurdlePageState();
}

class _WordHurdlePageState extends State<WordHurdlePage> {
  @override
  void didChangeDependencies() {
    Provider.of<Appprovider>(context, listen: false).init();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Word Hurdle'),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Consumer<Appprovider>(
                  builder: (context, provider, child) => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: provider.board.length,
                    itemBuilder: (context, index) {
                      final wordle = provider.board[index];
                      return WordleView(wordle: wordle);
                    },
                  ),
                ),
              ),
            ),
            Consumer<Appprovider>(
              builder: (context, provider, child) => KeyboardView(
                excludedLetters: provider.excludedletter,
                onPressed: (value) {
                  // print(value);
                  provider.inputLetter(value);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Consumer<Appprovider>(
                  builder: (context, provider, child) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              provider.deleteletter();
                            },
                            child: Text(
                              'DELETE',
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (!provider.isvalid) {
                                showmsg(
                                    context, 'Not a word in the dictionary');
                                return;
                              }
                              if (provider.shouldcheckans) {
                                provider.checkans();
                              }
                              if (provider.wins) {
                                showresult(
                                  context: context,
                                  title: 'You Win!!!!!',
                                  body: 'The word was ${provider.answer}',
                                  onPlayAgain: () {
                                    Navigator.pop(context);
                                    provider.reset();
                                  },
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                );
                              } else if (provider.noattempsleft) {
                                showresult(
                                  context: context,
                                  title: 'You lost',
                                  body: 'The word was ${provider.answer}',
                                  onPlayAgain: () {
                                    Navigator.pop(context);
                                    provider.reset();
                                  },
                                  onCancel: () {
                                    Navigator.pop(context);
                                  },
                                );
                              }
                            },
                            child: Text(
                              'SUBMIT',
                            ),
                          ),
                        ],
                      )),
            )
          ],
        ),
      ),
    );
  }
}
