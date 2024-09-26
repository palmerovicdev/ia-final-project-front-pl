import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme.dart';
import '../bloc/theme_selector_cubit.dart';

class WrapThemeSelectorWidget extends StatelessWidget {
  const WrapThemeSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            for (var i = 0; i < colorSeeds.length; i++)
              IconButton(
                icon: Icon(Icons.color_lens, color: colorSeeds[i]),
                onPressed: () {
                  context.read<ThemeSelectorCubit>().changeColorSeed(i);
                },
              ),
          ],
        )
      ],
    );
  }
}