import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../entities/user_entity.dart';

class SendMessageUseCase {
  final ApiRespository respository;
  SendMessageUseCase({required this.respository});
  Future<void> call(
      {required TextMessageEntity textMessageEntity,
      required String channelId}) {
    return respository.sendTextMessage(textMessageEntity, channelId);
  }
}
