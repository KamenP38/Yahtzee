import 'package:flutter/material.dart';

class ScoreBoxWidget extends StatelessWidget {
  final String name;
  final int? value;
  final bool picked;
  final VoidCallback? onPressed;

  const ScoreBoxWidget(
      {required this.name,
      required this.picked,
      required this.value,
      this.onPressed,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(children: [
        SizedBox(width: 150.0, height: 40.0, child: Text(name)),
      ]),
      const SizedBox(width: 30.0),
      Column(children: [
        picked == false
            ? SizedBox(
                width: 90.0,
                height: 25.0,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: const Text("Pick"),
                ),
              )
            : SizedBox(
                width: 90.0,
                height: 25.0,
                child: Center(child: Text(value.toString())))
      ]),
    ]);
  }
}