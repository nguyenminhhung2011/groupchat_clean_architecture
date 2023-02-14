import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class GetAllUserUseCase {
  final ApiRespository respository;
  GetAllUserUseCase({required this.respository});
  Stream<List<UserEntity>> call() {
    return respository.getAllUsers();
  }
}
