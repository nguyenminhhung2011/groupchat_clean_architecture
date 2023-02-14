import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/pages/home/home_page.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/main.dart';
import 'package:groupchat_clean_architecture/page_const.dart';

import '../../../../generated/assets..dart';
import '../../cubit/credential/credential_cubit.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/phone_number_field_widget.dart';
import '../../widgets/text_field_widget.dart';
import '../../widgets/theme/style.dart';
import '../../widgets/theme/template.dart';

class SignInWithEmailPassword extends StatefulWidget {
  SignInWithEmailPassword({super.key});

  @override
  State<SignInWithEmailPassword> createState() =>
      _SignInWithEmailPasswordState();
}

class _SignInWithEmailPasswordState extends State<SignInWithEmailPassword> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _check = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldState,
      // appBar: appBarWidget(
      //   IconButton(
      //     icon: const Icon(Icons.arrow_back, color: Colors.black),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   null,
      //   null,
      //   null,
      // ),
      body: BlocConsumer<CredentialCubit, CredentialState>(
        listener: (context, credentialState) {
          if (credentialState is CredentialSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (credentialState is CredentialFailure) {
            print("Credential is error");
          }
        },
        builder: (context, credentialState) {
          if (credentialState is CredentialLoading) {
            return Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            );
          }
          if (credentialState is CredentialSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is AuthenticatedState) {
                return HomePage(
                  uid: authState.uid,
                );
              } else {
                return _bodyWidget(widthDevice);
              }
            });
          }
          return _bodyWidget(widthDevice);
        },
      ),
    );
  }

  _bodyWidget(double widthDevice) => ListViewMain(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: textIconColorGray),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              Assets.mainAppIconAassets,
              fit: BoxFit.cover,
              width: widthDevice / 2.5,
              height: widthDevice / 2.5,
            ),
          ),
          const SizedBox(height: 40.0),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalAllSize * 4),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  'Log in to your account.',
                  style: headerText1.copyWith(
                    fontSize: headerSizeText,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15.0),
          TextFieldWidget(
            controller: _emailController,
            hint: "Enter Your Email",
            trailingIcon: Icons.email,
          ),
          const SizedBox(height: 10.0),
          TextFieldWidget(
            controller: _passwordController,
            hint: "Enter Your Password",
            isPasswordField: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Checkbox(
                value: _check,
                onChanged: (value) => setState(
                  () {
                    _check = value!;
                  },
                ),
              ),
              Text(
                'Remember Me',
                style: headerText1.copyWith(
                  fontSize: middleSizeText,
                ),
              ),
            ],
          ),
          ButtonCustom(
            title: 'Sign In',
            color: darkPrimaryColor,
            textColor: textIconColor,
            onPress: _submitSignIn,
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
                onTap: () => Navigator.pushNamed(
                    context, PageConst.signUpWithEmailPassword),
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

  void _submitSignIn() {
    if (_emailController.text.isEmpty) {
      return;
    }
    if (_passwordController.text.isEmpty) {
      return;
    }
    BlocProvider.of<CredentialCubit>(context).submitSignIn(
        user: UserEntity(
            email: _emailController.text, password: _passwordController.text));
  }
}
