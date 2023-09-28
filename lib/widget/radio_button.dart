import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? title;
  final String? type;

  const RadioButton({Key? key, required this.title, required this.type, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.only(top: 16, bottom: 16, left: 30, right: 30),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          side: BorderSide(color: type == title ? Colors.red : Colors.grey),
          backgroundColor: type == title ? Colors.red : Colors.white,
        ),
        child: Text(
          "$title",
          style: TextStyle(color: type == title ? Colors.white : Colors.grey),
        ),
      ),
    );
  }
}
