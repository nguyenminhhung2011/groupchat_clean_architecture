import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class ProfilePage extends StatelessWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
        IconButton(
          icon: Icon(Icons.arrow_back, color: textIconColorGray),
          onPressed: () => Navigator.pop(context),
        ),
        null,
        null,
        null,
      ),
    );
  }
}
