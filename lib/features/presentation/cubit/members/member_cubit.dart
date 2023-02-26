import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_member_from_group_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_message_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/send_text_message_usecase.dart';

import '../../../domain/entities/member_entity.dart';
import '../../../domain/use_cases/get_current_uid_usecase.dart';
import '../../../domain/use_cases/is_sign_in_usecase.dart';
import '../../../domain/use_cases/sign_out_usecase.dart';
part 'member_state.dart';

class MemberCubit extends Cubit<MemberState> {
  MemberCubit() : super(MemberInitial());

  // Future<void> getMembers({required String chennelId}) async{
  //   final
  // }
}
