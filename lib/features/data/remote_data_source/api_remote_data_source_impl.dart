import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  @override
  Future<void> forgotPassword(String email) {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) {
    // TODO: implement getCreateCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<String> getCurrentUId() {
    // TODO: implement getCurrentUId
    throw UnimplementedError();
  }

  @override
  Future<void> getUpdateUser(UserEntity user) {
    // TODO: implement getUpdateUser
    throw UnimplementedError();
  }

  @override
  Future<void> googleAuth() {
    // TODO: implement googleAuth
    throw UnimplementedError();
  }

  @override
  Future<bool> isSignIn() {
    // TODO: implement isSignIn
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(UserEntity user) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(UserEntity user) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
