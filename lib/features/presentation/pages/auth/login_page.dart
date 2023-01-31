import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListViewMain(
        children: [
          Text(
            'Login',
            style: headerText1.copyWith(color: primaryColor),
          )
        ],
      ),
    );
  }
}
