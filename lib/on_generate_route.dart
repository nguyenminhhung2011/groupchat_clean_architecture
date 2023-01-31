import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/login_page.dart';

class OnGenerateRoute {
  static Route<dynamic> route(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case "/":
        {
          return materialBuilder(widget: LoginPage());
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
