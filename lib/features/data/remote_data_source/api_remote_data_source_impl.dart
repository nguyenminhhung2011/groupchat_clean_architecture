import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/models/group_model.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/models/text_message_model.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/group_entity.dart';
import '../../domain/entities/text_message_entity.dart';
import 'models/user_model.dart';

class ApiRemoteDataSourceImpl implements ApiRemoteDataSource {
  final GoogleSignIn googleSignIn;
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ApiRemoteDataSourceImpl(this.firestore, this.auth,
      {required this.googleSignIn});
  @override
  Future<void> forgotPassword(String email) async {
    await auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> updateUserImage(String url, String uid) async {
    final userCollection = firestore.collection('users');
    userCollection.doc(uid).update({
      'profileUrl': url,
    });
  }

  @override
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = firestore.collection('users');
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> changePasswod(String newPassword, String uid) async {
    final user = auth.currentUser;
    await user?.updatePassword(newPassword).then((_) {
      print("Update password is successfully");
    }).catchError((error) {
      print(error.toString());
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollection = firestore.collection('users');
    final uid = await getCurrentUId();
    userCollection.doc(uid).get().then((userDoc) {
      final newUser = UserModel(
        name: user.name,
        uid: uid,
        phoneNumber: user.phoneNumber,
        email: user.email,
        profileUrl: user.profileUrl,
        isOnline: user.isOnline,
        status: user.status,
        dob: user.dob,
        gender: user.gender,
      ).toDocument();
      if (!userDoc.exists) {
        userCollection.doc(uid).set(newUser);
        return;
      } else {
        userCollection.doc(uid).update(newUser);
        // ignore: avoid_print
        print("user already exist");
        return;
      }
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<void> getUpdateUser(UserEntity user) async {
    print('Update user function is called');
    Map<String, dynamic> userInformation = Map();
    final userCollection = firestore.collection("users");

    // if (user.profileUrl != null && user.profileUrl != "") {
    //   userInformation['profileUrl'] = user.profileUrl;
    // }
    if (user.status != null && user.status != "") {
      userInformation['status'] = user.status;
    }
    if (user.phoneNumber != null && user.phoneNumber != "") {
      userInformation["phoneNumber"] = user.phoneNumber;
    }
    if (user.name != null && user.name != "") {
      userInformation["name"] = user.name;
    }

    print(userInformation);

    userCollection.doc(user.uid).update(userInformation);
  }

  @override
  Future<void> googleAuth() async {
    final collection = firestore.collection('users');
    try {
      final GoogleSignInAccount? account = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await account!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final information =
          (await auth.signInWithCredential(authCredential)).user;
      collection.doc(auth.currentUser!.uid).get().then((value) async {
        if (!value.exists) {
          var uid = auth.currentUser!.uid;
          var newUser = UserModel(
                  name: information!.displayName!,
                  email: information.email!,
                  phoneNumber: information.phoneNumber == null
                      ? ""
                      : information.phoneNumber!,
                  profileUrl:
                      information.photoURL == null ? "" : information.photoURL!,
                  isOnline: false,
                  status: "",
                  dob: "",
                  gender: "",
                  uid: information.uid)
              .toDocument();
          collection.doc(uid).set(newUser);
        }
      }).whenComplete(() => print("New User Created Successfully"));
    } catch (e) {
      print(e);
    }
  }

  @override
  // ignore: unnecessary_null_comparison
  Future<bool> isSignIn() async => auth.currentUser!.uid != null;

  @override
  Future<void> signIn(UserEntity user) async {
    await auth.signInWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signOut() async {
    await auth.signOut();
  }

  @override
  Future<void> signUp(UserEntity user) async {
    await auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
  }

  @override
  Future<void> signUpWithPhoneNumberr(String phoneNumber) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verficationId, int? resendToken) {},
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> sendTextMessage(
      TextMessageEntity textMessageEntity, String channelId) async {
    final messageRef = firestore
        .collection('groupChatChannel')
        .doc(channelId)
        .collection('messages');

    final messageId = messageRef.doc().id;

    final newMessage = TextMessageModel(
      content: textMessageEntity.content,
      messageId: messageId,
      receiverName: textMessageEntity.receiverName,
      recipientId: textMessageEntity.recipientId,
      senderId: textMessageEntity.senderId,
      senderName: textMessageEntity.senderName,
      time: textMessageEntity.time,
      type: textMessageEntity.type,
    ).toDocument();

    messageRef.doc(messageId).set(newMessage);
  }

  @override
  Stream<List<TextMessageEntity>> getMessages(String channelId) {
    final onToOneChatRef = firestore.collection("groupChatChannel");
    final messageRef = onToOneChatRef.doc(channelId).collection('messages');
    return messageRef.orderBy("time").snapshots().map((snap) =>
        snap.docs.map((doc) => TextMessageModel.fromSnapshot(doc)).toList());
  }

  @override
  Stream<List<GroupEntity>> getGroups() {
    final groupCollection = firestore.collection("groups");
    return groupCollection
        .orderBy("creationTime", descending: true)
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.docs.map((e) => GroupModel.fromSnapshot(e)).toList());
  }

  @override
  Future<void> getCreateGroup(GroupEntity groupEntity) async {
    final groupCollection = firestore.collection('groups');
    final groupId = groupCollection.doc().id;
    groupCollection.doc(groupId).get().then((value) {
      final newGroup = GroupModel(
        groupId: groupId,
        uid: groupEntity.uid,
        limitUsers: groupEntity.limitUsers,
        joinUsers: groupEntity.joinUsers,
        groupProfileImage: groupEntity.groupProfileImage,
        creationTime: groupEntity.creationTime,
        groupName: groupEntity.groupName,
        lastMessage: groupEntity.lastMessage,
      ).toDocument();
      if (!value.exists) {
        groupCollection.doc(groupId).set(newGroup);
        return;
      }
      return;
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Future<void> updateGroup(GroupEntity groupEntity) async {
    Map<String, dynamic> groupInformation = Map();
    final groupCollection = firestore.collection('groups');
    if (groupEntity.groupProfileImage != null &&
        groupEntity.groupProfileImage != "") {
      groupInformation['groupProfileImage'] = groupEntity.groupProfileImage;
    }
    if (groupEntity.groupName != null && groupEntity.groupName != "") {
      groupInformation["groupName"] = groupEntity.groupName;
    }
    if (groupEntity.lastMessage != null && groupEntity.lastMessage != "") {
      groupInformation["lastMessage"] = groupEntity.lastMessage;
    }
    if (groupEntity.creationTime != null) {
      groupInformation["creationTime"] = groupEntity.creationTime;
    }

    groupCollection.doc(groupEntity.groupId).update(groupInformation);
  }

  @override
  Future<void> joinGroup(GroupEntity groupEntity) async {
    final groupChatChannelCollection = firestore.collection("groupChatChannel");
    groupChatChannelCollection
        .doc(groupEntity.groupId)
        .get()
        .then((groupChannel) {
      print("Test uid: " + groupEntity.uid);
      Map<String, dynamic> groupMap = {
        "groupChannelId": groupEntity.groupId,
        "members": [groupEntity.uid]
      };
      if (!groupChannel.exists) {
        groupChatChannelCollection.doc(groupEntity.groupId).set(groupMap);
        return;
      }
      return;
    });
  }

  @override
  Future<void> addMemberToGroup(String uid, GroupEntity group) async {
    final groupChatChannelCollection = firestore.collection('groupChatChannel');
    groupChatChannelCollection.doc(group.groupId).get().then((groupChannel) {
      if (!groupChannel['members'].contains(uid)) {
        Map<String, dynamic> groupMap = {
          "members": groupChannel['members'].add(uid)
        };
        groupChatChannelCollection.doc(group.groupId).set(groupMap);
      }
    });
  }

  @override
  Future<List<String>> getMembersFromGroup(String channelId) async {
    return [];
  }

  @override
  static Future<List<String>> getMembers(String channelId) async {
    return [];
  }
}
