import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';

import '../../../../generated/assets..dart';
import '../../widgets/app_bar_widget.dart';
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
  FocusNode _focus = FocusNode();
  bool _check = false;
  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
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
      body: ListViewMain(
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: horizontalAllSize),
            padding: const EdgeInsets.all(paddingAllWidget - 10.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              border: Border.all(
                  width: 1,
                  color: _focus.hasFocus ? blueColor : Colors.transparent),
              color: _focus.hasFocus ? blueColor.withOpacity(0.1) : colorC1C1C2,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {},
                  child: Row(
                    children: [
                      Image.asset(Assets.appIconAssets,
                          height: 35.0, width: 35.0),
                      Icon(
                        Icons.keyboard_arrow_down_sharp,
                        size: middleSizeText,
                        color: _focus.hasFocus ? blueColor : colorC1C1C1,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 5.0),
                Expanded(
                  child: TextField(
                    focusNode: _focus,
                    decoration: InputDecoration(
                      hintText: "Enter your Phone Number",
                      border: InputBorder.none,
                      hintStyle: headerText3.copyWith(
                        color: colorC1C1C1,
                        fontSize: middleSizeText,
                      ),
                    ),
                  ),
                ),
              ],
            ),
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
                onTap: () {},
                child: Text(
                  'Sign Up',
                  style: headerText1.copyWith(
                    fontSize: lowSizeText,
                    color: blueColor,
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
