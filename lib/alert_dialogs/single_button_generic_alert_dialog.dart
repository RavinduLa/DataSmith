import 'package:flutter/material.dart';

class SingleButtonGenericAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String buttonText;

  const SingleButtonGenericAlertDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(buttonText))
      ],
    );
  }
}
