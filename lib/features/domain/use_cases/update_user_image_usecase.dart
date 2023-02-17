import '../entities/user_entity.dart';
import '../repositories/api_respositoy.dart';

class UpdateUserImageUseCase {
  final ApiRespository respository;
  UpdateUserImageUseCase({required this.respository});
  Future<void> call(String url, String uid) {
    return respository.updateUserImage(url, uid);
  }
}
