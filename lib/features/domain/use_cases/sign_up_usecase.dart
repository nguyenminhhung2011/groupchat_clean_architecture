import '../entities/user_entity.dart';
import '../repositories/api_respositoy.dart';

class SignUpUseCase {
  final ApiRespository respository;
  SignUpUseCase({required this.respository});
  Future<void> signUp(UserEntity userEntity) {
    return respository.signUp(userEntity);
  }
}
