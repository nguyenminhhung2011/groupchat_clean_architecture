import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/page_const.dart';

import '../../../../generated/assets..dart';
import '../../widgets/app_bar_widget.dart';
import '../../widgets/phone_number_field_widget.dart';
import '../../widgets/theme/style.dart';
import '../../widgets/theme/template.dart';

class SignInWithPhoneNumberPage extends StatefulWidget {
  SignInWithPhoneNumberPage({super.key});

  @override
  State<SignInWithPhoneNumberPage> createState() =>
      _SignInWithPhoneNumberPageState();
}

class _SignInWithPhoneNumberPageState extends State<SignInWithPhoneNumberPage> {
  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _check = false;

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
      body: ListViewMain(
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
          PhoneNumberFieldWidget(controller: _phoneNumberController),
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
            onPress: () {},
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
                    context, PageConst.signUpWithPhoneNoPage),
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
      ),
    );
  }
}