import 'package:flutter/material.dart';

import '../models/dice_model.dart';
import '../models/scores_tracker.dart';
import 'diebox_widget.dart';
import 'scorebox_widget.dart';


class GameWidget extends StatelessWidget {
  const GameWidget({
    super.key,
    required DiceModel diceMod,
    required ScoresTrackerModel scoresMod,
  })  : _diceMod = diceMod,
        _scoresMod = scoresMod;

  final DiceModel _diceMod;
  final ScoresTrackerModel _scoresMod;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      ListenableBuilder(
          listenable: _diceMod,
          builder: (BuildContext context, Widget? child) {
            return DiceWidget(diceMod: _diceMod);
          }),
      const SizedBox(height: 20.0),
      ListenableBuilder(
        listenable: _diceMod,
        builder: (BuildContext context, Widget? child) {
          return ElevatedButton(
            onPressed: _diceMod.rollCount < 3 ? () => _diceMod.roll() : null,
            child: Text("Roll Dice (${_diceMod.rollCount})"),
          );
        },
      ),
      const SizedBox(height: 20.0),
      ListenableBuilder(
          listenable: _diceMod,
          builder: (BuildContext context, Widget? child) {
            return ScoresWidget(scoresMod: _scoresMod, diceMod: _diceMod);
          }),
    ]);
  }
}

class DiceWidget extends StatelessWidget {
  const DiceWidget({
    super.key,
    required DiceModel diceMod,
  }) : _diceMod = diceMod;

  final DiceModel _diceMod;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: List.generate(5, (i) {
          return DieBoxWidget(
              number: _diceMod.dice[i].value,
              isHeld: _diceMod.dice[i].isHeld,
              onPressed: () => _diceMod.toggleHeld(i));
        }));
  }
}

class ScoresWidget extends StatelessWidget {
  const ScoresWidget({
    super.key,
    required ScoresTrackerModel scoresMod,
    required DiceModel diceMod,
  }) : _scoresMod = scoresMod, _diceMod = diceMod;

  final ScoresTrackerModel _scoresMod;
  final DiceModel _diceMod;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: _scoresMod.scores.take(7).map((scores) {
              return ScoreBoxWidget(
                name: scores.name,
                picked: scores.picked,
                value: scores.value,
                onPressed:
                    _diceMod.dice.any((die) => die.value == null)
                        ? null
                        : () {
                            List<int> diceValues = _diceMod.dice
                                .where((die) => die.value != null)
                                .map((die) => die.value!)
                                .toList();

                            _scoresMod.calculateScore(
                                scores.name, diceValues);
                            _diceMod.resetDice();
                          },
              );
            }).toList(),
          ),
          const SizedBox(width: 100.0),
          Column(
            children: [
              ..._scoresMod.scores
                  .skip(7)
                  .map((scores) => ScoreBoxWidget(
                        name: scores.name,
                        picked: scores.picked,
                        value: scores.value,
                        onPressed: _diceMod.dice
                                .any((die) => die.value == null)
                            ? null
                            : () {
                            List<int> diceValues = _diceMod.dice
                                .where((die) => die.value != null)
                                .map((die) => die.value!)
                                .toList();

                            _scoresMod.calculateScore(
                                scores.name, diceValues);
                            _diceMod.resetDice();
                          },
                      ))
                  .toList(),
              const SizedBox(height: 20.0),
              TotalScoreWidget(scoresMod: _scoresMod),
            ],
          )
        ]);
  }
}

class TotalScoreWidget extends StatelessWidget {
  const TotalScoreWidget({
    super.key,
    required ScoresTrackerModel scoresMod,
  }) : _scoresMod = scoresMod;

  final ScoresTrackerModel _scoresMod;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 140.0,
        height: 25.0,
        decoration: BoxDecoration(
          border:
              Border.all(color: Colors.red, width: 2.0),
        ),
        child: Center(
            child: Text(
          "Total Score: ${_scoresMod.getTotalScore}",
          style: const TextStyle(
              fontWeight: FontWeight.bold),
        )));
  }
}