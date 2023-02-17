import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_all_user_use_case.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_update_user_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/update_user_image_usecase.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUserUseCase getAllUserUseCase;
  final UpdateUserImageUseCase updateUserImageUseCase;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserCubit({
    required this.getAllUserUseCase,
    required this.updateUserImageUseCase,
    required this.getUpdateUserUseCase,
  }) : super(UserInitial());

  Future<void> getUsers() async {
    emit(UserLoading());
    final streamResponse = getAllUserUseCase.call();
    streamResponse.listen((event) {
      emit(UserLoaded(users: event));
    });
  }

  Future<void> updateUser({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await getUpdateUserUseCase.call(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateAvata(
      {required String profileUrl, required String uid}) async {
    try {
      await updateUserImageUseCase.call(profileUrl, uid);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
