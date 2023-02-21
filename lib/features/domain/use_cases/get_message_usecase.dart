import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class GetMessageUseCase {
  final ApiRespository respository;
  GetMessageUseCase({required this.respository});
  Stream<List<TextMessageEntity>> call(String channelId) {
    return respository.getMessages(channelId);
  }
}
