import 'package:flutter/material.dart';

class NumberView extends StatelessWidget {
  final int? number;
  final VoidCallback? addition;
  final VoidCallback? subtraction;

  const NumberView({Key? key, required this.number, required this.addition, required this.subtraction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
              onPressed: subtraction,
              icon: const Icon(
                Icons.indeterminate_check_box_rounded,
                color: Colors.red,
              )),
          Text("$number"),
          IconButton(
              onPressed: addition,
              icon: const Icon(
                Icons.add_box_rounded,
                color: Colors.red,
              ))
        ],
      ),
    );
  }
}
