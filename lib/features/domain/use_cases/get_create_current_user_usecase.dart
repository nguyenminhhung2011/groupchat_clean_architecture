import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class GetCreateCurrentUserUseCaes {
  final ApiRespository respository;
  GetCreateCurrentUserUseCaes({required this.respository});
  Future<void> call(UserEntity user) {
    return respository.getCreateCurrentUser(user);
  }
}
