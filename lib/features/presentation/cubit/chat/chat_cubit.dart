import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_message_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/send_text_message_usecase.dart';

import '../../../domain/use_cases/get_current_uid_usecase.dart';
import '../../../domain/use_cases/is_sign_in_usecase.dart';
import '../../../domain/use_cases/sign_out_usecase.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final GetMessageUseCase getMessageUseCase;
  final SendMessageUseCase sendMessageUseCase;
  ChatCubit({required this.getMessageUseCase, required this.sendMessageUseCase})
      : super(ChatInitial());

  Future<void> getMessages({required String channelId}) async {
    emit(ChatLoading());
    final messageResponse = getMessageUseCase.call(channelId);
    messageResponse.listen((event) {
      emit(ChatLoaded(chats: event));
    });
  }

  Future<void> sendMessage(
      {required TextMessageEntity textMessageEntity,
      required String channelId}) async {
    try {
      await sendMessageUseCase.call(
          textMessageEntity: textMessageEntity, channelId: channelId);
    } on SocketException catch (_) {
      emit(ChatFailure());
    } catch (_) {
      emit(ChatFailure());
    }
  }
}
