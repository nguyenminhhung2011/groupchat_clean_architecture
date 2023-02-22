import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';

import '../entities/group_entity.dart';
import '../entities/text_message_entity.dart';

abstract class ApiRespository {
  Future<void> getCreateCurrentUser(UserEntity user);
  Future<void> googleAuth();
  Future<void> forgotPassword(String email);

  Future<void> getCreateGroup(GroupEntity groupEntity);
  Stream<List<GroupEntity>> getGroups();
  Future<void> joinGroup(GroupEntity groupEntity);
  // Future<void> joinGroup(GroupEntity groupEntity);
  // Future<void> updateGroup(GroupEntity groupEntity);

  Future<void> updateGroup(GroupEntity groupEntity);
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signUpWithPhoneNumberr(String phoneNumber);
  Future<void> signOut();
  Future<void> getUpdateUser(UserEntity user);
  Future<String> getCurrentUId();
  Stream<List<UserEntity>> getAllUsers();
  Future<void> updateUserImage(String imageUrl, String uid);
  Future<void> changePasswod(String newPassword, String uid);
  // Future<String> createOneToOneChatChannel(EngageUserEntity engageUserEntity);
  // Future<String> getChannelId(EngageUserEntity engageUserEntity);
  // Future<void> createNewGroup(MyChatEntity myChatEntity,List<String> selectUserList);
  // Future<void> getCreateNewGroupChatRoom(MyChatEntity myChatEntity,List<String> selectUserList);
  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId);
  Stream<List<TextMessageEntity>> getMessages(String channelId);
  // Future<void> addToMyChat(MyChatEntity myChatEntity);
  // Stream<List<MyChatEntity>> getMyChat(String uid);
}
