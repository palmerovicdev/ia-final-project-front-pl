import 'package:get_it/get_it.dart';
import '../../number_translator/data/data_sources/auth/auth_datasource.dart';
import '../../number_translator/data/data_sources/number_translator/number_translator_datasource.dart';
import '../../number_translator/data/data_sources/score/score_datasource.dart';
import '../../number_translator/data/repositories/auth/auth_repository.dart';
import '../../number_translator/data/repositories/number_translator/number_translator_repository.dart';
import '../../number_translator/data/repositories/score/score_repository.dart';
import '../../number_translator/domain/repositories/auth/auth_domain_repository.dart';
import '../../number_translator/domain/repositories/number_translator/number_translator_domain_repository.dart';
import '../../number_translator/domain/repositories/score/score_domain_repository.dart';
import '../../number_translator/domain/use_cases/auth/auth_service.dart';
import '../../number_translator/domain/use_cases/number_translator/number_translator_service.dart';
import '../../number_translator/domain/use_cases/score/score_service.dart';
import '../../number_translator/presentation/bloc/auth/auth_cubit.dart';
import '../../number_translator/presentation/bloc/configurations/configurations_cubit.dart';
import '../../number_translator/presentation/bloc/game/game_cubit.dart';
import '../../number_translator/presentation/bloc/game/selection_game_cubit.dart';
import '../../number_translator/presentation/bloc/score/score_cubit.dart';
import '../../number_translator/presentation/bloc/translation/number_translator_cubit.dart';
import '../../theme/presentation/bloc/theme_selector_cubit.dart';
import '../config_data/configuration_data.dart';
import '../connection/connection_helper.dart';

final serviceLocator = GetIt.instance;

void setupServiceLocator() {
  serviceLocator.registerSingleton<ConfigurationData>(ConfigurationData());
  serviceLocator.registerSingleton<ConnectionHelper>(ConnectionHelper());

  setupDataServices();
  setupDomainServices();

  serviceLocator.registerSingleton<NumberTranslatorCubit>(NumberTranslatorCubit());
  serviceLocator.registerSingleton<ConfigurationsCubit>(ConfigurationsCubit());
  serviceLocator.registerSingleton<GameCubit>(GameCubit());
  serviceLocator.registerSingleton<ThemeSelectorCubit>(ThemeSelectorCubit());
  serviceLocator.registerSingleton<AuthCubit>(AuthCubit());
  serviceLocator.registerSingleton<ScoreCubit>(ScoreCubit());
  serviceLocator.registerSingleton<SelectionGameCubit>(SelectionGameCubit());

}

void setupDataServices() {
  serviceLocator.registerSingleton<NumberTranslatorDatasource>(
    NumberTranslatorDatasourceImpl(
      connectionHelper: serviceLocator.get<ConnectionHelper>(),
    ),
  );

  serviceLocator.registerSingleton<NumberTranslatorRepository>(
    NumberTranslatorRepositoryImpl(datasource: serviceLocator.get<NumberTranslatorDatasource>()),
  );

  serviceLocator.registerSingleton<AuthDatasource>(
    AuthDatasourceImpl(connectionHelper: serviceLocator.get<ConnectionHelper>()),
  );

  serviceLocator.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(authDatasource: serviceLocator.get<AuthDatasource>()),
  );

  serviceLocator.registerSingleton<ScoreDatasource>(
    ScoreDatasourceImpl(
      connectionHelper: serviceLocator.get<ConnectionHelper>(),
    ),
  );

  serviceLocator.registerSingleton<ScoreRepository>(
    ScoreRepositoryImpl(
      scoreDatasource: serviceLocator.get<ScoreDatasource>(),
    ),
  );
}

void setupDomainServices() {
  serviceLocator.registerSingleton<NumberTranslatorDomainRepository>(
    NumberTranslatorDomainRepositoryImpl(repository: serviceLocator.get<NumberTranslatorRepository>()),
  );

  serviceLocator.registerSingleton<NumberTranslatorService>(
    NumberTranslatorServiceImpl(
      repository: serviceLocator.get<NumberTranslatorDomainRepository>(),
    ),
  );

  serviceLocator.registerSingleton<AuthDomainRepository>(
    AuthDomainRepositoryImpl(authRepository: serviceLocator.get<AuthRepository>()),
  );

  serviceLocator.registerSingleton<AuthService>(
    AuthServiceImpl(repository: serviceLocator.get<AuthDomainRepository>()),
  );

  serviceLocator.registerSingleton<ScoreDomainRepository>(
    ScoreDomainRepositoryImpl(
      scoreRepository: serviceLocator.get<ScoreRepository>(),
    ),
  );

  serviceLocator.registerSingleton<ScoreService>(
    ScoreServiceImpl(
      scoreRepository: serviceLocator.get<ScoreDomainRepository>(),
    ),
  );
}