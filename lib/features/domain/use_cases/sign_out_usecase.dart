import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class SignOutUseCase {
  final ApiRespository respository;
  SignOutUseCase({required this.respository});
  Future<void> call() {
    return respository.signOut();
  }
}
