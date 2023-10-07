import 'package:flutter/material.dart';

class Score {
  final String name;
  int? value;
  bool picked;

  Score({required this.name, this.value, this.picked = false});
}

class ScoresTrackerModel with ChangeNotifier {
  int totalScore = 0;
  List<Score> scores = [
    Score(name: "Ones"),
    Score(name: "Twos"),
    Score(name: "Threes"),
    Score(name: "Fours"),
    Score(name: "Fives"),
    Score(name: "Sixes"),
    Score(name: "Three of a Kind"),
    Score(name: "Four of a Kind"),
    Score(name: "Full House"),
    Score(name: "Small Straight"),
    Score(name: "Large Straight"),
    Score(name: "Yahtzee"),
    Score(name: "Chance")
  ];

  int get getTotalScore => totalScore;

  bool get hasGameEnded {
    return scores.every((score) => score.picked);
  }

  void pickScore(String name, int value) {
    final score =
        scores.firstWhere((score) => score.name == name && !score.picked);
    score.value = value;
    score.picked = true;
    totalScore += value;
    notifyListeners();
  }

  void calculateScore(String name, List<int> diceValues) {
    diceValues.sort();

    Set<int> uniqueVals = diceValues.toSet();

    switch (name) {
      case "Ones":
        Iterable<int> ones = diceValues.where((val) => val == 1);
        int onesTotal = ones.fold(0, (a, b) => a + b);
        pickScore(name, onesTotal);
        break;

      case "Twos":
        Iterable<int> twos = diceValues.where((val) => val == 2);
        int twosTotal = twos.fold(0, (a, b) => a + b);
        pickScore(name, twosTotal);
        break;

      case "Threes":
        Iterable<int> threes = diceValues.where((val) => val == 3);
        int threesTotal = threes.fold(0, (a, b) => a + b);
        pickScore(name, threesTotal);
        break;

      case "Fours":
        Iterable<int> fours = diceValues.where((val) => val == 4);
        int foursTotal = fours.fold(0, (a, b) => a + b);
        pickScore(name, foursTotal);
        break;

      case "Fives":
        Iterable<int> fives = diceValues.where((val) => val == 5);
        int fivesTotal = fives.fold(0, (a, b) => a + b);
        pickScore(name, fivesTotal);
        break;

      case "Sixes":
        Iterable<int> sixes = diceValues.where((val) => val == 6);
        int sixesTotal = sixes.fold(0, (a, b) => a + b);
        pickScore(name, sixesTotal);
        break;

      case "Chance":
        int chanceTotal = diceValues.reduce((a, b) => a + b);
        pickScore(name, chanceTotal);
        break;

      case "Three of a Kind":
        if (diceValues
            .any((d) => diceValues.where((d2) => d2 == d).length >= 3)) {
          int threeofkindscore = diceValues.reduce((a, b) => a + b);
          pickScore(name, threeofkindscore);
        } else {
          pickScore(name, 0);
        }
        break;

      case "Four of a Kind":
        if (diceValues
            .any((d) => diceValues.where((d2) => d2 == d).length >= 4)) {
          int fourofkindscore = diceValues.reduce((a, b) => a + b);
          pickScore(name, fourofkindscore);
        } else {
          pickScore(name, 0);
        }
        break;

      case "Full House":
        if (uniqueVals.length == 2 &&
            uniqueVals
                .any((d) => diceValues.where((d2) => d2 == d).length == 3)) {
          pickScore(name, 25);
        } else {
          pickScore(name, 0);
        }
        break;

      case "Small Straight":
        if (uniqueVals.containsAll([1, 2, 3, 4]) ||
            uniqueVals.containsAll([2, 3, 4, 5]) ||
            uniqueVals.containsAll([3, 4, 5, 6])) {
          pickScore(name, 30);
        } else {
          pickScore(name, 0);
        }
        break;

      case "Large Straight":
        if (uniqueVals.containsAll([1, 2, 3, 4, 5]) ||
            uniqueVals.containsAll([2, 3, 4, 5, 6])) {
          pickScore(name, 40);
        } else {
          pickScore(name, 0);
        }
        break;

      case "Yahtzee":
        if (uniqueVals.length == 1) {
          pickScore(name, 50);
        } else {
          pickScore(name, 0);
        }
        break;
    }
    notifyListeners();
  }

  void resetScores() {
    totalScore = 0;
    scores.forEach((score) {
      score.value = null;
      score.picked = false;
    });
    notifyListeners();
  }
}
