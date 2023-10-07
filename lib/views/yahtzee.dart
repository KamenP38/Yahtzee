import 'package:flutter/material.dart';

import '../models/dice_model.dart';
import '../models/scores_tracker.dart';
import '../widgets/game_widget.dart';

class Yahtzee extends StatefulWidget {
  const Yahtzee({super.key});

  @override
  State<Yahtzee> createState() => _YahtzeeState();
}

class _YahtzeeState extends State<Yahtzee> {
  final DiceModel _diceMod = DiceModel(5);
  final ScoresTrackerModel _scoresMod = ScoresTrackerModel();

  Future<void> _gameOverDialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your final score is: ${_scoresMod.getTotalScore}'),
        actions: <Widget>[
          TextButton(
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
              _resetGame();
            },
          ),
        ],
      ),
    );
  }

  _resetGame() {
    _diceMod.resetDice();
    _scoresMod.resetScores();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _scoresMod,
      builder: (context, _) {
        if (_scoresMod.hasGameEnded) {
          Future.delayed(Duration.zero, () {
            _gameOverDialogBuilder(context);
          });
        }
        return SingleChildScrollView(
          child: GameWidget(diceMod: _diceMod, scoresMod: _scoresMod),
        );
      },
    );
  }
}
