part of 'selection_game_cubit.dart';

abstract class SelectionGameState extends Equatable {
  const SelectionGameState();
}

class SelectionGameInitial extends SelectionGameState {
  final bool isFirstTime;
  final bool isInitializing;

  const SelectionGameInitial({
    this.isFirstTime = true,
    this.isInitializing = true,
  });

  @override
  List<Object> get props => [isFirstTime, isInitializing];

  SelectionGameInitial copyWith({bool? isFirstTime, bool? isInitializing}) {
    return SelectionGameInitial(
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isInitializing: isInitializing ?? this.isInitializing,
    );
  }
}

class SelectionGameInProgress extends SelectionGameState {
  final int wordIndex;
  final List<String> words;
  final int round;
  final int points;
  final double healthPercentage;
  final int number;

  const SelectionGameInProgress({
    required this.wordIndex,
    required this.round,
    required this.points,
    required this.healthPercentage,
    required this.words,
    required this.number,
  });

  @override
  List<Object> get props =>
      [wordIndex, round, points, healthPercentage, number];

  // copy with
  SelectionGameInProgress copyWith({
    String? word,
    int? round,
    int? points,
    double? healthPercentage,
    List<String>? words,
  }) {
    return SelectionGameInProgress(
      wordIndex: wordIndex,
      round: round ?? this.round,
      points: points ?? this.points,
      healthPercentage: healthPercentage ?? this.healthPercentage,
      words: words ?? this.words,
      number: number,
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
