import 'package:flutter/material.dart';

class DieBoxWidget extends StatelessWidget {
  final int? number;
  final bool isHeld;
  final VoidCallback? onPressed;

  const DieBoxWidget(
      {this.number, required this.isHeld, this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            border: isHeld ? Border.all(color: Colors.red, width: 2.0) : null),
        child: ElevatedButton(
            onPressed: onPressed,
            child: SizedBox(
              height: 200.0,
              width: 200.0,
              child: Center(
                child: Text(
                  number != null ? number.toString() : "",
                  style: const TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )),
      ),
    );
  }
}