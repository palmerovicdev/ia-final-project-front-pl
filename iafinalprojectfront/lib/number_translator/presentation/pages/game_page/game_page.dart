import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import '../../../../config/service_locator/service_locator.dart';
import '../../../../go_router/routes.dart';
import '../../../domain/use_cases/auth/auth_service.dart';
import '../../bloc/game/game_cubit.dart';
import '../../widgets/custom_animated_timer.dart';
import '../../widgets/custom_text_form_field_widget.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = serviceLocator.get<GameCubit>();
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state is! GameInitial || state.isFirstTime || state.finished) {
          return;
        }
        cubit.responseTextController.text = '';
      },
      builder: (context, state) {
        return Scaffold(
          appBar: (!(state as GameInitial).finished && !state.isInitializing)
              ? AppBar(
                  title: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Juego 2'),
                      Gap(5),
                      Text('Escribe números contrarreloj',
                          style: TextStyle(fontSize: 12))
                    ],
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      cubit.resetState();
                      context.pop();
                    },
                  ))
              : null,
          body: state.isInitializing
              ? Center(
                  child: CustomAnimatedTimer(
                    duration: const Duration(seconds: 3),
                    size: const Size(150, 150),
                    onFinished: () {
                      cubit.startGame();
                    },
                  ),
                )
              : state.finished
                  ? const _GameFinished()
                  : const _Game(),
        );
      },
    );
  }
}

class _Game extends StatelessWidget {
  const _Game();

  @override
  Widget build(BuildContext context) {
    var cubit = serviceLocator.get<GameCubit>();
    var textTheme = Theme.of(context).textTheme;
    return BlocBuilder<GameCubit, GameState>(
      buildWhen: (previous, current) => !(current as GameInitial).finished,
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Animate(
              effects: const [
                ScaleEffect(duration: Duration(milliseconds: 50))
              ],
              child: const Icon(Icons.directions_run,
                  size: 86, color: Colors.lightBlueAccent),
            ),
            Text(
              cubit.currentNumber.toString(),
              style: textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 32),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SizedBox(
                height: 100,
                width: double.infinity,
                child: CustomTextFormField(
                  controller: cubit.responseTextController,
                  readOnly: false,
                  autofocus: true,
                ),
              ),
            ),
            const Gap(20),
            CustomAnimatedTimer(
              duration: const Duration(seconds: 60),
              size: const Size(50, 50),
              onFinished: () => cubit.finishState(() {}),
              fontSize: 26,
              strokeWeight: 4.0,
            ),
            const Gap(20),
            ElevatedButton(
              onPressed: () {
                cubit.finishState(() {});
              },
              child: Text(tr('game_finish')),
            ),
          ],
        );
      },
    );
  }
}

class _GameFinished extends StatelessWidget {
  const _GameFinished();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var authService = serviceLocator.get<AuthService>();

    saveScore(authService);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Gap(45),
          const Icon(
            Icons.stars_outlined,
            size: 128,
            color: Colors.lightBlueAccent,
          ),
          const Gap(20),
          Text(
            tr('game_your_score'),
            style: textTheme.titleLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          Text(
            '${serviceLocator.get<GameCubit>().currentPoints}',
            style: textTheme.titleLarge?.copyWith(
              fontSize: 32,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Gap(20),
          FilledButton.icon(
              onPressed: () => serviceLocator.get<GameCubit>().resetState(),
              icon: const Icon(Icons.redo_rounded),
              label: Text(tr('game_try_again'))),
          const Gap(20),
          FilledButton.icon(
              onPressed: () {
                serviceLocator.get<GameCubit>().hardReset(
                    () => context.pushNamed(Routes.numberTranslator.name));
              },
              icon: const Icon(Icons.exit_to_app_outlined),
              label: Text(tr('game_exit'))),
        ],
      ),
    );
  }

  void saveScore(AuthService authService) =>
      serviceLocator.get<GameCubit>().saveCurrentScore(authService);
}
