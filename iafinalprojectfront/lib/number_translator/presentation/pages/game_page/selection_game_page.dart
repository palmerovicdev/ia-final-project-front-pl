import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iafinalprojectfront/config/extension/extensions.dart';

import '../../bloc/game/selection_game_cubit.dart';
import '../../widgets/custom_animated_health_widget.dart';
import '../../widgets/custom_number_words_widget.dart';

class SelectionGamePage extends StatelessWidget {
  const SelectionGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectionGameCubit, SelectionGameState>(listener: (context, state) {
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
              const Gap(36),
              CustomAnimatedHealthWidget(
                percentage: state.healthPercentage,
                onFinished: () => BlocProvider.of<SelectionGameCubit>(context).finishGame(),
              ),
              const Gap(72),
              Text(
                '${state.number}'.formatNumber(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 52.0, fontWeight: FontWeight.w500),
              ),
              const Gap(72),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: CustomNumberWordsWidget(
                  words: state.words,
                  wordIndex: state.wordIndex,
                  responseTextController: BlocProvider.of<SelectionGameCubit>(context).responseTextController,
                ),
              ),
              const Gap(144),
              SizedBox(
                width: MediaQuery.of(context).size.width - 120,
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                    side: BorderSide(color: Theme.of(context).colorScheme.primary),
                  ),
                  onPressed: () {
                    BlocProvider.of<SelectionGameCubit>(context).finishCurrentRound();
                  },
                  child: const Text('Aceptar'),
                ),
              ),
            ],
          ),
        );
      }
      if (state is SelectionGameFinished) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selection Game', style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w500)),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Gap(108),
                Text(
                  'Puntuación: ${state.points}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 52.0, fontWeight: FontWeight.w500),
                ),
                const Gap(72),
                Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.primary,
                  size: 220.0,
                ),
                const Gap(72),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: (MediaQuery.of(context).size.width - 120) / 2,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                            side: BorderSide(color: Theme.of(context).colorScheme.primary),
                          ),
                          onPressed: () => BlocProvider.of<SelectionGameCubit>(context).reset(),
                          child: const Text('Re-Jugar'),
                        ),
                      ),SizedBox(
                        width: (MediaQuery.of(context).size.width - 120) / 2,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
                            side: BorderSide(color: Theme.of(context).colorScheme.onSecondary),
                          ),
                          onPressed: () => context.pop(),
                          child: const Text('Salir'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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
