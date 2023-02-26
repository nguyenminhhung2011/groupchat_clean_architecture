import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class GetMemberFromGroupUseCase {
  final ApiRespository respository;
  GetMemberFromGroupUseCase({required this.respository});
  Future<List<String>> call(String channelId) {
    return respository.getMembersFromGroup(channelId);
  }
}
