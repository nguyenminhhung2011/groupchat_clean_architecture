import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/text_field_widget.dart';
import 'package:groupchat_clean_architecture/main.dart';
import 'package:groupchat_clean_architecture/page_const.dart';

import '../../../../generated/assets..dart';
import '../../cubit/credential/credential_cubit.dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/phone_number_field_widget.dart';
import '../../widgets/theme/style.dart';
import '../../widgets/theme/template.dart';

class SignUpWithEmalPassword extends StatefulWidget {
  SignUpWithEmalPassword({super.key});

  @override
  State<SignUpWithEmalPassword> createState() => _SignUpWithEmalPasswordState();
}

class _SignUpWithEmalPasswordState extends State<SignUpWithEmalPassword> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repasswordController = TextEditingController();
  bool _check = false;

  @override
  void dispose() {
    // _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldState,
      appBar: appBarWidget(
        IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
          if (credentialState is CredentialFailure) {}
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
                return const Scaffold(
                  backgroundColor: Colors.black,
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
            alignment: Alignment.center,
            child: Image.asset(
              Assets.mainAppIconAassets,
              fit: BoxFit.cover,
              width: widthDevice / 2.5,
              height: widthDevice / 2.5,
            ),
          ),
          const SizedBox(height: 30.0),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalAllSize * 4),
              child: FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  'Create your account.',
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
          const SizedBox(height: 10.0),
          TextFieldWidget(
            controller: _repasswordController,
            hint: "Enter re pasword",
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
            title: 'Sign Up',
            color: darkPrimaryColor,
            textColor: textIconColor,
            onPress: _submitSignIn,
          ),
        ],
      );

  void _submitSignIn() {
    if (_emailController.text.isEmpty) {
      print("email is null");
      return;
    }
    if (_passwordController.text.isEmpty) {
      print("password is null");
      return;
    }
    if (_repasswordController.text.isEmpty) {
      print("re_pass is null");
      return;
    }
    if (_repasswordController.text == _passwordController.text) {
    } else {
      print("re pass is invalid");
      return;
    }
    BlocProvider.of<CredentialCubit>(context).submitSignUp(
        user: UserEntity(
            email: _emailController.text,
            password: _repasswordController.text));
  }
}
