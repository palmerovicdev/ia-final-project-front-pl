import '../../data_sources/score/score_datasource.dart';
import '../../models/user_score_model.dart';

abstract class ScoreRepository {
  Future<bool> save(UserScoreModel userScoreModel);

  Future<List<UserScoreModel>> getAll();
}

class ScoreRepositoryImpl extends ScoreRepository {
  final ScoreDatasource scoreDatasource;

  ScoreRepositoryImpl({
    required this.scoreDatasource,
  });

  @override
  Future<List<UserScoreModel>> getAll() async {
    return await scoreDatasource.getAll();
  }

  @override
  Future<bool> save(UserScoreModel userScoreModel) async {
    return await scoreDatasource.save(UserScoreModel(
      username: userScoreModel.username,
      score: userScoreModel.score,
      date: userScoreModel.date,
    ));
  }
}