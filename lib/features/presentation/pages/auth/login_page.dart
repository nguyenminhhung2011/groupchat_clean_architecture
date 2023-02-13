import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/credential/credential_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/home/home_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:groupchat_clean_architecture/generated/assets..dart';
import 'package:groupchat_clean_architecture/page_const.dart';

import '../../widgets/button_border.dart';
import '../../widgets/button_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // final TextEditingController _emailController = TextEditingController();q
  // final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldState,
      appBar: appBarWidget(
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {},
        ),
        null,
        null,
        null,
      ),
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            // do nothing
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return const Scaffold(
              backgroundColor: Colors.white,
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is AuthenticatedState) {
                  return HomePage(uid: authState.uid);
                } else {
                  return _bodyWidget(widthDevice, context);
                }
              },
            );
          }
          return _bodyWidget(widthDevice, context);
        },
      ),
    );
  }

  ListViewMain _bodyWidget(double widthDevice, BuildContext context) {
    return ListViewMain(
      children: [
        Align(
            alignment: Alignment.center,
            child: Image.asset(
              Assets.signInMainImageAssets,
              fit: BoxFit.cover,
              width: widthDevice / 2,
              height: widthDevice / 2,
            )),
        Align(
          alignment: Alignment.center,
          child: Text(
            'Let\'s you in',
            style: headerText1.copyWith(fontSize: headerSizeText),
          ),
        ),
        const SizedBox(height: 20.0),
        ButtonBorder(
            callback: () {},
            title: 'Continue with facebook',
            icon: const Padding(
              padding: EdgeInsets.only(left: 15.0),
              child: Icon(
                Icons.facebook,
                color: blueColor,
              ),
            )),
        const SizedBox(height: 10.0),
        ButtonBorder(
          callback: () {
            BlocProvider.of<CredentialCubit>(context).submitGoogleAuth();
          },
          title: 'Continue with Google',
          icon: Image.asset(Assets.googleAssets, height: 22.0, width: 22.0),
        ),
        const SizedBox(height: 15.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            children: const [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Divider(thickness: 1),
                ),
              ),
              Text('Or'),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
                  child: Divider(thickness: 1),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        ButtonCustom(
          title: 'Sign in with Phone Number',
          onPress: () =>
              Navigator.pushNamed(context, PageConst.signInWithPhoneNoPage),
          color: darkPrimaryColor,
          textColor: textIconColor,
        ),
        const SizedBox(height: 10.0),
        ButtonCustom(
          title: 'Sign in with Email and Password',
          color: darkPrimaryColor,
          textColor: textIconColor,
          onPress: () =>
              Navigator.pushNamed(context, PageConst.signInWithEmailPassword),
        ),
        const SizedBox(height: 10.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account? ',
              style: headerText3.copyWith(
                fontSize: lowSizeText,
              ),
            ),
            InkWell(
              onTap: () {},
              child: Text(
                'Sign Up',
                style: headerText1.copyWith(
                  fontSize: lowSizeText,
                  color: purpleColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
