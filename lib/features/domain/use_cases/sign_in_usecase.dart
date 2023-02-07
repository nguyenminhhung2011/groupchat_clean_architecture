import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class SignInUseCase {
  final ApiRespository respository;
  SignInUseCase({required this.respository});
  Future<void> signIn(UserEntity userEntity) {
    return respository.signIn(userEntity);
  }
}
