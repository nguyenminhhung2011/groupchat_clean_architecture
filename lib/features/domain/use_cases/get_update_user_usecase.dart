import '../entities/user_entity.dart';
import '../repositories/api_respositoy.dart';

class GetUpdateUserUseCase {
  final ApiRespository respository;
  GetUpdateUserUseCase({required this.respository});
  Future<void> call(UserEntity user) {
    return respository.getUpdateUser(user);
  }
}
  