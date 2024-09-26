import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iafinalprojectfront/go_router/routes.dart';

import '../number_translator/presentation/pages/auth/auth_page.dart';
import '../number_translator/presentation/pages/configurations/configurations_page.dart';
import '../number_translator/presentation/pages/game_page/game_page.dart';
import '../number_translator/presentation/pages/game_page/selection_game_page.dart';
import '../number_translator/presentation/pages/translation/number_translator_page.dart';
import '../number_translator/presentation/pages/user_score/user_score.dart';

final router = GoRouter(
  initialLocation: Routes.authPage.routePath,
  routes: [
    GoRoute(
      path: Routes.numberTranslator.routePath,
      name: Routes.numberTranslator.name,
      pageBuilder: (context, state) => const MaterialPage(
        child: NumberTranslatorPage(),
      ),
    ),
    GoRoute(
      path: Routes.configurations.routePath,
      name: Routes.configurations.name,
      pageBuilder: (context, state) =>
          const MaterialPage(child: ConfigurationsPage()),
    ),
    GoRoute(
      path: Routes.gamePage.routePath,
      name: Routes.gamePage.name,
      pageBuilder: (context, state) =>
          const MaterialPage(child: GamePage()),
    ),
    GoRoute(
      path: Routes.authPage.routePath,
      name: Routes.authPage.name,
      pageBuilder: (context, state) =>
          const MaterialPage(child: AuthPage()),
    ),
    GoRoute(
      path: Routes.userScore.routePath,
      name: Routes.userScore.name,
      pageBuilder: (context, state) => const MaterialPage(child: UserScorePage()),
    ),
    GoRoute(
      path: Routes.selectionGame.routePath,
      name: Routes.selectionGame.name,
      pageBuilder: (context, state) => const MaterialPage(child: SelectionGamePage()),
    ),
  ],
);
