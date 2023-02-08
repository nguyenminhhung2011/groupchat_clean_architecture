import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class IsSignInUseCase {
  final ApiRespository respository;
  IsSignInUseCase({required this.respository});
  Future<bool> call() {
    return respository.isSignIn();
  }
}
