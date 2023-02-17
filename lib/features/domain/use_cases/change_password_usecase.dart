import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class ChangePasswordUseCase {
  final ApiRespository respository;
  ChangePasswordUseCase({required this.respository});
  Future<void> call(String newPasswrd, String uid) {
    return respository.changePasswod(newPasswrd, uid);
  }
}
