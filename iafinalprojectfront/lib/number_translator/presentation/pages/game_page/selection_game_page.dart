import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../bloc/game/selection_game_cubit.dart';
import '../../widgets/custom_animated_health_widget.dart';

class SelectionGamePage extends StatelessWidget {
  const SelectionGamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectionGameCubit, SelectionGameState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Selection Game'),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomAnimatedHealthWidget(
                percentage: 1.0,
                onFinished: () {}, //TODO 9/25/24 palmerodev : add function for finish game
              ),
              const Gap(20),

            ],
          ),
        );
      },
    );
  }
}
