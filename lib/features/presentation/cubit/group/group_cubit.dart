import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_create_group_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_groups_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/update_group_usecase.dart';

import '../../../domain/entities/group_entity.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetGroupsUseCase getGroupsUseCase;
  final GetCreateGroupUseCase getCreateGroupUseCase;
  final UpdateGroupUseCase updateGroupUseCase;
  GroupCubit(
      {required this.getGroupsUseCase,
      required this.getCreateGroupUseCase,
      required this.updateGroupUseCase})
      : super(GroupInitial());

  Future<void> getGroups() async {
    emit(GroupLoading());
    final streamResponse = getGroupsUseCase.call();
    streamResponse.listen((event) {
      emit(GroupLoaded(groups: event));
    });
  }

  Future<void> getCreateGroup({required GroupEntity groupEntity}) async {
    try {
      await getCreateGroupUseCase.call(groupEntity);
    } on SocketException catch (_) {
      emit(GroupFailure());
    } catch (_) {
      emit(GroupFailure());
    }
  }

  Future<void> updateGroup({required GroupEntity groupEntity}) async {
    try {
      await updateGroupUseCase.call(groupEntity: groupEntity);
    } on SocketException catch (_) {
      emit(GroupFailure());
    } catch (_) {
      emit(GroupFailure());
    }
  }
}
