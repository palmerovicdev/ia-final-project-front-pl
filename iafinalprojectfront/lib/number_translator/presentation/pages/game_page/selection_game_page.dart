import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../bloc/game/selection_game_cubit.dart';
import '../../widgets/custom_animated_health_widget.dart';
import '../../widgets/custom_number_words_widget.dart';

class SelectionGamePage extends StatelessWidget {
  const SelectionGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectionGameCubit, SelectionGameState>(listener: (context, state) {
      if (state is SelectionGameFinished) {
        BlocProvider.of<SelectionGameCubit>(context).reset();
      }
    }, builder: (context, state) {
      if (state is SelectionGameInitial) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selection Game'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAnimatedHealthWidget(
                percentage: 1.0,
                onFinished: () {
                  BlocProvider.of<SelectionGameCubit>(context).finishGame();
                },
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: () {
                  BlocProvider.of<SelectionGameCubit>(context).startGame();
                },
                child: const Text('Comenzar'),
              ),
            ],
          ),
        );
      }
      if (state is SelectionGameInProgress) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selection Game'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAnimatedHealthWidget(
                percentage: 1.0,
                onFinished: () => BlocProvider.of<SelectionGameCubit>(context).finishGame(),
              ),
              const Gap(20),
              Text(
                '${state.number}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 64.0, fontWeight: FontWeight.w500),
              ),
              const Gap(20),
              Flexible(
                child: CustomNumberWordsWidget(
                  words: state.words,
                  wordIndex: state.wordIndex,
                  responseTextController: BlocProvider.of<SelectionGameCubit>(context).responseTextController,
                ),
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: () {
                  BlocProvider.of<SelectionGameCubit>(context).finishCurrentRound();
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
      }
      if (state is SelectionGameFinished) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selection Game'),
            actions: [
              IconButton(
                onPressed: () {
                  BlocProvider.of<SelectionGameCubit>(context).reset();
                },
                icon: const Icon(Icons.replay),
              ),
            ],
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Puntuación: ${state.points}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 64.0, fontWeight: FontWeight.w500),
              ),
              const Gap(20),
              Icon(
                Icons.favorite,
                color: Theme.of(context).colorScheme.primary,
                size: 64.0,
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: () => context.pop(),
                child: const Text('Salir'),
              ),
            ],
          ),
        );
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Selection Game'),
          actions: [
            IconButton(
              onPressed: () {}, //TODO 9/25/24 palmerodev : add function for finish game
              icon: const Icon(Icons.check),
            ),
          ],
        ),
      );
    });
  }
}
