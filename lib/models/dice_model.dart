import 'package:flutter/material.dart';
import 'dart:math';

class Die {
  int? value;
  bool isHeld;

  Die({this.isHeld = false, this.value});

  void roll() {
    if (!isHeld) {
      Random rng = Random();
      value = rng.nextInt(6) + 1;
    }
  }
}

class DiceModel extends ChangeNotifier {
  final List<Die> dice;
  final int count;
  int rollCount;
  bool isNull;

  DiceModel(this.count)
      : isNull = false,
        rollCount = 0,
        dice = List.generate(count, (i) => Die());

  // Roll all dice that are not held
  void roll() {
    bool hasChanged = false;

    for (var die in dice) {
      die.roll();
      hasChanged = true;
    }

    if (hasChanged) {
      rollCount++;
      isNull = false;
      notifyListeners();
    }
  }

  // Hold/Unhold a specific die
  void toggleHeld(int dieIndex) {
    for (var die in dice) {
      if (die.value == null) isNull = true;
    }

    if (!isNull && (dieIndex >= 0 && dieIndex < count)) {
      dice[dieIndex].isHeld = !dice[dieIndex].isHeld;
      notifyListeners();
    }
  }

  // Reset dice values after player picked a combination
  void resetDice() {
    for (var die in dice) {
      die.value = null;
      rollCount = 0;
      for (var die in dice) {
        if (die.value == null) {
          isNull = true;
          die.isHeld = false;
        }
      }
      notifyListeners();
    }
  }
}