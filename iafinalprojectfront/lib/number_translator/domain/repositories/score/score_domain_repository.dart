
import '../../../data/models/user_score_model.dart';
import '../../../data/repositories/score/score_repository.dart';
import '../../entities/user_score_entity.dart';

abstract class ScoreDomainRepository {
  Future<bool> save(UserScoreEntity userScoreEntity);

  Future<List<UserScoreEntity>> getAll();
}

class ScoreDomainRepositoryImpl extends ScoreDomainRepository {
  final ScoreRepository scoreRepository;

  ScoreDomainRepositoryImpl({
    required this.scoreRepository,
  });

  @override
  Future<List<UserScoreEntity>> getAll() async {
    return (await scoreRepository.getAll())
        .map((userScoreModel) => UserScoreEntity(username: userScoreModel.username, score: userScoreModel.score, date: userScoreModel.date))
        .toList();
  }

  @override
  Future<bool> save(UserScoreEntity userScoreEntity) async {
    return await scoreRepository.save(UserScoreModel(
      username: userScoreEntity.username,
      score: userScoreEntity.score,
      date: userScoreEntity.date,
    ));
  }
}