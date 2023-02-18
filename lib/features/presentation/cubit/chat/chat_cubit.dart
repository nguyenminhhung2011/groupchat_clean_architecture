import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';

import '../../../domain/use_cases/get_current_uid_usecase.dart';
import '../../../domain/use_cases/is_sign_in_usecase.dart';
import '../../../domain/use_cases/sign_out_usecase.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
}
