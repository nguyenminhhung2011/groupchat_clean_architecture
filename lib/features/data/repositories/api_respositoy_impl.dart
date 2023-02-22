import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/repositories/api_respositoy.dart';

import '../../domain/entities/group_entity.dart';
import '../../domain/entities/text_message_entity.dart';

class ApiRespositoryImpl implements ApiRespository {
  final ApiRemoteDataSource remoteDataSource;

  ApiRespositoryImpl({required this.remoteDataSource});

  @override
  Future<void> forgotPassword(String email) =>
      remoteDataSource.forgotPassword(email);

  @override
  Stream<List<UserEntity>> getAllUsers() => remoteDataSource.getAllUsers();

  @override
  Future<void> getCreateCurrentUser(UserEntity user) =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() => remoteDataSource.getCurrentUId();

  @override
  Future<void> getUpdateUser(UserEntity user) =>
      remoteDataSource.getUpdateUser(user);

  @override
  Future<void> googleAuth() => remoteDataSource.googleAuth();

  @override
  Future<bool> isSignIn() => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) => remoteDataSource.signUp(user);
  @override
  Future<void> signUpWithPhoneNumberr(String phoneNumber) =>
      remoteDataSource.signUpWithPhoneNumberr(phoneNumber);

  @override
  Future<void> updateUserImage(String url, String uid) =>
      remoteDataSource.updateUserImage(url, uid);

  @override
  Future<void> changePasswod(String newPassword, String uid) =>
      remoteDataSource.changePasswod(newPassword, uid);

  @override
  Future<void> sendTextMessage(
          TextMessageEntity textMessageEntity, String channelId) =>
      remoteDataSource.sendTextMessage(textMessageEntity, channelId);

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) =>
      remoteDataSource.getMessages(channelId);
  @override
  Stream<List<GroupEntity>> getGroups() => remoteDataSource.getGroups();
  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) =>
      remoteDataSource.getCreateGroup(groupEntity);

  @override
  Future<void> updateGroup(GroupEntity groupEntity) =>
      remoteDataSource.updateGroup(groupEntity);
  @override
  Future<void> joinGroup(GroupEntity groupEntity) =>
      remoteDataSource.joinGroup(groupEntity);
}
