import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:iafinalprojectfront/config/service_locator/service_locator.dart';
import 'package:iafinalprojectfront/number_translator/domain/entities/consult_entity.dart';
import 'package:iafinalprojectfront/number_translator/domain/use_cases/auth/auth_service.dart';
import 'package:iafinalprojectfront/number_translator/domain/use_cases/score/score_service.dart';

import '../../../domain/entities/user_score_entity.dart';
import '../../../domain/use_cases/number_translator/number_translator_service.dart';

part 'selection_game_state.dart';

class SelectionGameCubit extends Cubit<SelectionGameState> {
  SelectionGameCubit() : super(SelectionGameInitial());
  final TextEditingController responseTextController = TextEditingController();

  Future<void> startGame() async {
    var number = Random().nextInt(1000000000);
    var response = await serviceLocator.get<NumberTranslatorService>().makeTranslate(request: ConsultEntity(number: '$number'), isFromDigit: true);
    var words = response.data.hashResponse.split(' ');
    var currentRound = state is SelectionGameInitial ? 1 : state is SelectionGameInProgress ? (state as SelectionGameInProgress).round + 1 : 1;
    var currentPoints = state is SelectionGameInitial ? 0 : state is SelectionGameInProgress ? (state as SelectionGameInProgress).points : 0;
    emit(SelectionGameInProgress(
      words: words,
      wordIndex: Random().nextInt(words.length),
      round: currentRound,
      points: currentPoints,
      healthPercentage: 1.0,
    ));
  }

  void finishCurrentRound() {
    if (state is! SelectionGameInProgress) return;
    var currentState = state as SelectionGameInProgress;
    var currentUserWord = responseTextController.text;
    if (currentUserWord == currentState.words[currentState.wordIndex]) {
      emit(currentState.copyWith(
        round: currentState.round + 1,
        points: (currentState.points + currentState.healthPercentage * currentState.round) as int,
        healthPercentage: currentState.healthPercentage,
      ));
      return;
    }
    if (currentState.healthPercentage - currentState.round * 0.05 <= 0) {
      emit(SelectionGameFinished(points: currentState.points));
      return;
    }
    emit(currentState.copyWith(healthPercentage: currentState.healthPercentage - currentState.round * 0.05));
  }

  void finishGame() {
    if (state is! SelectionGameInProgress) return;
    serviceLocator.get<ScoreService>().save(
      UserScoreEntity(
        username: serviceLocator.get<AuthService>().get()!.username,
        score: '${(state as SelectionGameFinished).points}',
        date: DateTime.now().toString(),
      ),
    );
    reset();
  }

  void reset() {
    emit(SelectionGameInitial());
  }
}
