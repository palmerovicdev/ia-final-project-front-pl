part of 'selection_game_cubit.dart';

abstract class SelectionGameState extends Equatable {
  const SelectionGameState();
}

class SelectionGameInitial extends SelectionGameState {
  @override
  List<Object> get props => [];
}

class SelectionGameInProgress extends SelectionGameState {
  final int wordIndex;
  final List<String> words;
  final int round;
  final int points;
  final double healthPercentage;

  const SelectionGameInProgress({required this.wordIndex, required this.round, required this.points, required this.healthPercentage, required this.words});

  @override
  List<Object> get props => [wordIndex, round, points, healthPercentage];

  // copy with
  SelectionGameInProgress copyWith({String? word, int? round, int? points, double? healthPercentage, List<String>? words}) {
    return SelectionGameInProgress(
      wordIndex: wordIndex,
      round: round ?? this.round,
      points: points ?? this.points,
      healthPercentage: healthPercentage ?? this.healthPercentage,
      words: words ?? this.words,
    );
  }
}

class SelectionGameFinished extends SelectionGameState {
  final int points;

  @override
  List<Object> get props => [points];

  const SelectionGameFinished({required this.points});

  SelectionGameFinished copyWith({int? points}) {
    return SelectionGameFinished(
      points: points ?? this.points,
    );
  }
}
