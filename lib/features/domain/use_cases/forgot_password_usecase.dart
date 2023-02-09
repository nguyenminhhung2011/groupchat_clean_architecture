import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class ForgotPasswordUseCase {
  final ApiRespository respository;
  ForgotPasswordUseCase({required this.respository});
  Future<void> call(String email) {
    return respository.forgotPassword(email);
  }
}
