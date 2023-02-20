import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

class GetCreateGroupUseCase {
  final ApiRespository respository;
  GetCreateGroupUseCase({required this.respository});
  Future<void> call(GroupEntity groupEntity) {
    return respository.getCreateGroup(groupEntity);
  }
}
