import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/auth/login_page.dart';
import 'package:groupchat_clean_architecture/on_generate_route.dart';
import 'package:groupchat_clean_architecture/page_const.dart';
import 'features/presentation/cubit/credential/credential_cubit.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => di.sl<AuthCubit>()..appStarted(),
        ),
        BlocProvider<CredentialCubit>(
          create: (_) => di.sl<CredentialCubit>(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}
