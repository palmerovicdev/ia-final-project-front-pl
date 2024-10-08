
import '../../../data/models/user_model.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import '../../entities/user_entity.dart';

abstract class AuthDomainRepository {
  Future<bool> signUp(UserEntity userEntity);

  Future<bool> logIn(UserEntity userEntity);
}

class AuthDomainRepositoryImpl extends AuthDomainRepository {
  final AuthRepository authRepository;

  AuthDomainRepositoryImpl({
    required this.authRepository,
  });

  @override
  Future<bool> logIn(UserEntity userEntity) async {
    return await authRepository.logIn(UserModel(
      username: userEntity.username,
      password: userEntity.password,
    ));
  }

  @override
  Future<bool> signUp(UserEntity userEntity) async {
    return await authRepository.signUp(UserModel(
      username: userEntity.username,
      password: userEntity.password,
    ));
  }
}