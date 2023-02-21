import 'dart:io';

import 'package:flutter/material.dart';

Widget profileWidget({required String? imageUrl, required File? image}) {
  print("image value $image");
  if (image == null) {
    if (imageUrl == null) {
      return Image.network(
          'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
          fit: BoxFit.cover);
    } else {
      return Image.network(
          'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png',
          fit: BoxFit.cover);
    }
  } else {
    return Image.file(image, fit: BoxFit.cover);
  }
}
