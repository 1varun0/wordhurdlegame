import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showmsg(BuildContext context,String msg) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
        ),
      ),
    );

void showresult({
  required BuildContext context,
  required String title,
  required String body,
  required VoidCallback onPlayAgain,
  required VoidCallback onCancel,
}) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: onCancel,
                child: Text('QUIT'),
              ),
              TextButton(
                onPressed: onPlayAgain,
                child: Text('PLAY AGAIN'),
              )

            ],
          ));
}
