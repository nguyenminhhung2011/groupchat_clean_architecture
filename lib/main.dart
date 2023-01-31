import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/login_page.dart';
import 'package:groupchat_clean_architecture/on_generate_route.dart';
import 'package:groupchat_clean_architecture/page_const.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group Chat',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Montserrat',
        primarySwatch: Colors.blue,
      ),
      initialRoute: PageConst.loginPage,
      onGenerateRoute: OnGenerateRoute.route,
      routes: {
        "/": (context) {
          return const LoginPage();
        }
      },
    );
  }
}
