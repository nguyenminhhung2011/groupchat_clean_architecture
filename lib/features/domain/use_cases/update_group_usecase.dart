import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class UpdateGroupUseCase {
  final ApiRespository respository;
  UpdateGroupUseCase({required this.respository});
  Future<void> call({required GroupEntity groupEntity}) {
    return respository.updateGroup(groupEntity);
  }
}
