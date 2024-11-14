import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iafinalprojectfront/config/extension/extensions.dart';
import 'package:iafinalprojectfront/config/service_locator/service_locator.dart';
import 'package:iafinalprojectfront/number_translator/presentation/widgets/custom_animated_timer.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../../bloc/game/selection_game_cubit.dart';
import '../../widgets/custom_animated_health_widget.dart';
import '../../widgets/custom_number_words_widget.dart';

class SelectionGamePage extends StatelessWidget {
  const SelectionGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectionGameCubit, SelectionGameState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SelectionGameInitial) {
            return Center(
              child: CustomAnimatedTimer(
                onFinished: () =>
                    BlocProvider.of<SelectionGameCubit>(context).startGame(),
                size: const Size(150, 150),
                duration: const Duration(seconds: 3),
              ),
            );
          }
          if (state is SelectionGameInProgress) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<SelectionGameCubit>(context).reset();
                    context.pop();
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                title: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Juego 1'),
                    Gap(5),
                    Text(
                      'Completa los espacios en blanco',
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                ),
              ),
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Gap(36),
                  CustomAnimatedHealthWidget(
                    percentage: state.healthPercentage,
                    onFinished: () =>
                        BlocProvider.of<SelectionGameCubit>(context)
                            .finishGame(),
                  ),
                  const Gap(72),
                  Text(
                    '${state.number}'.formatNumber(),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 52.0, fontWeight: FontWeight.w500),
                  ),
                  const Gap(72),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: CustomNumberWordsWidget(
                      words: state.words,
                      wordIndex: state.wordIndex,
                      responseTextController:
                          BlocProvider.of<SelectionGameCubit>(context)
                              .responseTextController,
                    ),
                  ),
                  const Gap(144),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 120,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 16.0),
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                      ),
                      onPressed: () {
                        BlocProvider.of<SelectionGameCubit>(context)
                            .finishCurrentRound();
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
              body: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Gap(108),
                    Text(
                      'Puntuación: ${state.points}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 52.0, fontWeight: FontWeight.w500),
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
                      child: Column(
                        children: [
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 16.0),
                                side: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              onPressed: () =>
                                  BlocProvider.of<SelectionGameCubit>(context)
                                      .reset(),
                              child: const Text('Jugar de nuevo'),
                            ),
                          ),
                          const Gap(8),
                          SizedBox(
                            width: (MediaQuery.of(context).size.width - 50) / 2,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0)),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32.0, vertical: 16.0),
                                side: BorderSide(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary),
                              ),
                              onPressed: () {
                                BlocProvider.of<SelectionGameCubit>(context)
                                    .reset();
                                context.pop();
                              },
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
                  onPressed:
                      () {}, //TODO 9/25/24 palmerodev : add function for finish game
                  icon: const Icon(Icons.check),
                ),
              ],
            ),
          );
        });
  }
}

class _SelectionGameIntroduction extends StatefulWidget {
  const _SelectionGameIntroduction();

  @override
  State<_SelectionGameIntroduction> createState() => _SelectionGameIntroductionState();
}

class _SelectionGameIntroductionState extends State<_SelectionGameIntroduction> {
  @override
  Widget build(BuildContext context) {
    var cubit = serviceLocator.get<SelectionGameCubit>();
    var colorScheme = Theme.of(context).colorScheme;
    return IntroductionScreen(
      globalBackgroundColor: colorScheme.surface,
      scrollPhysics: const BouncingScrollPhysics(),
      pages: [
        PageViewModel(
          image: const Icon(
            Icons.question_answer_outlined,
            size: 128,
            color: Colors.lightBlueAccent,
          ),
          title: tr('game_first_introduction'),
          body: tr('game_first_description'),
        ),
        PageViewModel(
          image: const Icon(
            Icons.timelapse_rounded,
            size: 128,
            color: Colors.lightBlueAccent,
          ),
          title: tr('game_second_introduction'),
          body: tr('game_second_description'),
        ),
        PageViewModel(
          image: const Icon(
            Icons.golf_course_sharp,
            color: Colors.lightBlueAccent,
            size: 128,
          ),
          title: tr('game_third_introduction'),
          body: tr('game_third_description'),
        ),
      ],
      onDone: () => cubit.saveFirstTime(),
      done: Text(tr('game_done_button')),
      next: Text(tr('game_next_button')),
      back: Text(tr('game_back_button')),
      showDoneButton: true,
      showBackButton: true,
      dotsDecorator: DotsDecorator(
        color: colorScheme.primary,
        activeColor: colorScheme.onInverseSurface,
        size: const Size(8, 8),
        activeSize: const Size(14, 14),
      ),
    );
  }
}
