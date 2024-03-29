import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/single_chat_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/login_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/otp_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/sign_in_with_email_password_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/sign_in_with_pn_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/sign_up_pn_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/sign_up_with_email_password.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/home/home_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/home/profile_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/single_chat/setting_single_chat_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/single_chat/single_chat_page.dart';
import 'package:groupchat_clean_architecture/page_const.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case PageConst.loginPage:
        {
          return materialBuilder(widget: LoginPage());
        }
      case PageConst.signInWithPhoneNoPage:
        {
          return materialBuilder(widget: SignInWithPhoneNumberPage());
        }
      case PageConst.signUpWithPhoneNoPage:
        {
          return materialBuilder(widget: SignUpPhoneNumberPage());
        }
      case PageConst.signUpWithEmailPassword:
        {
          return materialBuilder(widget: SignUpWithEmalPassword());
        }
      case PageConst.otpPage:
        {
          return materialBuilder(widget: OtpPage());
        }
      case PageConst.signInWithEmailPassword:
        {
          return materialBuilder(widget: SignInWithEmailPassword());
        }
      case PageConst.singleChatPage:
        {
          if (args is SingleChatEntity) {
            return materialBuilder(
                widget: SingleChatPage(
              singleChatEntity: args,
            ));
          } else {
            return materialBuilder(
              widget: ErrorPage(),
            );
          }
        }
      case PageConst.settingSingleChatPage:
        {
          if (args is String) {
            return materialBuilder(
                widget: SettingSingleChatPage(
              groupId: args,
            ));
          } else {
            return materialBuilder(widget: ErrorPage());
          }
        }
      case PageConst.profilePage:
        {
          if (args is String) {
            return materialBuilder(
              widget: ProfilePage(
                uid: args,
              ),
            );
          } else {
            return materialBuilder(
              widget: const ErrorPage(),
            );
          }
        }
      default:
        return materialBuilder(widget: ErrorPage());
    }
  }
}

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
      ),
      body: const Center(
        child: Text('Error Page'),
      ),
    );
  }
}

MaterialPageRoute materialBuilder({required Widget widget}) {
  return MaterialPageRoute(builder: (_) => widget);
}
