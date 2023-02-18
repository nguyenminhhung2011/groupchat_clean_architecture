import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_groups_usecase.dart';

import '../../../domain/entities/group_entity.dart';

part 'group_state.dart';

class GroupCubit extends Cubit<GroupState> {
  final GetGroupsUseCase getGroupsUseCase;
  GroupCubit({required this.getGroupsUseCase}) : super(GroupInitial());

  Future<void> getGroups() async {
    emit(GroupLoading());
    final streamResponse = getGroupsUseCase.call();
    streamResponse.listen((event) {
      emit(GroupLoaded(groups: event));
    });
  }
}
