import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class GetGroupsUseCase {
  final ApiRespository respository;
  GetGroupsUseCase({required this.respository});
  Stream<List<GroupEntity>> call() {
    return respository.getGroups();
  }
}
