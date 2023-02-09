import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class GoogleAuthUseCase {
  final ApiRespository respository;
  GoogleAuthUseCase({required this.respository});
  Future<void> call() {
    return respository.googleAuth();
  }
}
