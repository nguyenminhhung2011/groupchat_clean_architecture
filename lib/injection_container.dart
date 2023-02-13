import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source_impl.dart';
import 'package:groupchat_clean_architecture/features/data/repositories/api_respositoy_impl.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/forgot_password_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/get_current_uid_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/google_auth_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/is_sign_in_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/sign_in_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/sign_out_usecase.dart';
import 'package:groupchat_clean_architecture/features/domain/use_cases/sign_up_usecase.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/credential/credential_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //bloc
  sl.registerFactory<AuthCubit>(
    () => AuthCubit(
      isSignInUseCase: sl.call(),
      signOutUseCase: sl.call(),
      getCurrentUidUseCase: sl.call(),
    ),
  );

  sl.registerFactory<CredentialCubit>(
    () => CredentialCubit(
      signUpUseCase: sl.call(),
      signInUseCase: sl.call(),
      forgotPasswordUseCase: sl.call(),
      getCreateCurrentUserUseCaes: sl.call(),
      googleAuthUseCase: sl.call(),
    ),
  );

  //UseCase
  sl.registerLazySingleton<ForgotPasswordUseCase>(
      () => ForgotPasswordUseCase(respository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCaes>(
      () => GetCreateCurrentUserUseCaes(respository: sl.call()));
  sl.registerLazySingleton<GetCurrentUidUseCase>(
      () => GetCurrentUidUseCase(respository: sl.call()));
  sl.registerLazySingleton<GoogleAuthUseCase>(
      () => GoogleAuthUseCase(respository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(respository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(respository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(respository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(respository: sl.call()));

  //Responsitory
  sl.registerLazySingleton<ApiRespository>(
      () => ApiRespositoryImpl(remoteDataSource: sl.call()));
  //Remote DataSource
  sl.registerLazySingleton<ApiRemoteDataSource>(() =>
      ApiRemoteDataSourceImpl(sl.call(), sl.call(), googleSignIn: sl.call()));
  //Local Source
  //External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
  sl.registerLazySingleton(() => googleSignIn);
}
