import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import '../../../../config/service_locator/service_locator.dart';
import '../../../domain/entities/consult_entity.dart';
import '../../../domain/entities/user_score_entity.dart';
import '../../../domain/use_cases/auth/auth_service.dart';
import '../../../domain/use_cases/number_translator/number_translator_service.dart';
import '../../../domain/use_cases/score/score_service.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(const GameInitial());
  int currentNumber = 0;
  String currentTranslation = 'cero';
  DateTime initiationTime = DateTime.now();
  int currentPoints = 0;
  static const maxLimit = 999999999;
  final TextEditingController responseTextController = TextEditingController();

  void saveFirstTime() {
    emit(state.copyWith(isFirstTime: false, isInitializing: true));
  }

  void startGame({int limit = 1000}) async {
    currentNumber = Random().nextInt(limit);
    var translationService = serviceLocator.get<NumberTranslatorService>();
    currentTranslation = (await translationService.makeTranslate(
            request: ConsultEntity(number: '$currentNumber'),
            isFromDigit: false))
        .data
        .hashResponse;
    debugPrint('currentTranslation: $currentTranslation');
    initiationTime = DateTime.now();
    emit(state.copyWith(
        isInitializing: false, isFirstTime: false, randomNumberLimit: limit));
  }

  void finishState(void Function()? onWrong, {String? text = ''} ) {
    if (responseTextController.text == currentTranslation &&
        !(state as GameInitial).finished) {
      var now = DateTime.now();
      var difference = now.difference(initiationTime).inSeconds;
      currentPoints += currentNumber ~/ difference;
      var nextLimit = (state as GameInitial).randomNumberLimit + 10000;
      startGame(limit: nextLimit > maxLimit ? maxLimit : nextLimit);
    } else {
      emit(state.copyWith(finished: true));
      onWrong?.call();
    }
    initiationTime = DateTime.now();
  }

  void resetState() {
    responseTextController.text = '';
    currentPoints = 0;
    emit(const GameInitial(isFirstTime: false, isInitializing: true));
  }

  void hardReset(void Function() onFinish) {
    responseTextController.text = '';
    currentPoints = 0;
    onFinish.call();
    emit(const GameInitial(isFirstTime: false, isInitializing: true));
  }

  void saveCurrentScore(AuthService authService) => authService.get() != null
      ? serviceLocator.get<ScoreService>().save(
            UserScoreEntity(
              username: authService.get()!.username,
              score: '${serviceLocator.get<GameCubit>().currentPoints}',
              date: DateTime.now().toString(),
            ),
          )
      : null;
}
