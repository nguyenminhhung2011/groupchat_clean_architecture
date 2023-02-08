import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/sign_up_usecase.dart';
part 'credential_state.dart';

class CredentialCubit extends Cubit<CredentialState> {
  final SignUpUseCase signUpUseCase;
  CredentialCubit(super.initialState, {required this.signUpUseCase});
}
