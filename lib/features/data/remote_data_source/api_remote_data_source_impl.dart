import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Stream<List<UserEntity>> getAllUsers() {
    final userCollection = firestore.collection('users');
    return userCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList());
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
    Map<String, dynamic> userInformation = Map();
    final userCollection = firestore.collection("users");

    if (user.profileUrl != null && user.profileUrl != "") {
      userInformation['profileUrl'] = user.profileUrl;
    }
    if (user.status != null && user.status != "") {
      userInformation['status'] = user.status;
    }
    if (user.phoneNumber != null && user.phoneNumber != "") {
      userInformation["phoneNumber"] = user.phoneNumber;
    }
    if (user.name != null && user.name != "") {
      userInformation["name"] = user.name;
    }

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
}
