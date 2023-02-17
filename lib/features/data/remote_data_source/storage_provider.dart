import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageProviderRemoteDataSource {
  static FirebaseStorage _storage = FirebaseStorage.instance;

  static Future<String> upLoadFile({required File file}) async {
    final ref = _storage.ref().child(
        "Documents/${DateTime.now().millisecondsSinceEpoch}${getNameOnly(file.path)}");
    final upLoadTask = ref.putFile(file);
    final imageUrl =
        (await upLoadTask.whenComplete(() {})).ref.getDownloadURL();
    return await imageUrl;
  }

  static String getNameOnly(String path) {
    return path.split('/').last.split('%').last.split("?").first;
  }
}
