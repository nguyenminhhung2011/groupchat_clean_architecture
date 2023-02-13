import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/forgot_password_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/google_auth_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/sign_up_usecase.dart';
import '../../../domain/use_cases/sign_in_usecase.dart';
part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  final SignInUseCase signInUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final GoogleAuthUseCase googleAuthUseCase;
  final GetCreateCurrentUserUseCaes getCreateCurrentUserUseCaes;

  CredentialCubit({
    required this.signUpUseCase,
    required this.signInUseCase,
    required this.forgotPasswordUseCase,
    required this.getCreateCurrentUserUseCaes,
    required this.googleAuthUseCase,
  }) : super(CredentialInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(user);
      emit(CredentialSuccess());
    } catch (_) {
      emit(CredentialFailure());
      // ignore: dead_code_catch_following_catch
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitGoogleAuth() async {
    try {
      googleAuthUseCase.call();
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(user);
      await getCreateCurrentUserUseCaes(user);
      emit(CredentialSuccess());
    } catch (_) {
      emit(CredentialFailure());
      // ignore: dead_code_catch_following_catch
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      await forgotPasswordUseCase.call(email);
    } catch (_) {
      emit(CredentialFailure());
      // ignore: dead_code_catch_following_catch
    } on SocketException catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> googleAuthSubmit() async {
    emit(CredentialLoading());
    try {
      await googleAuthSubmit.call();
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
