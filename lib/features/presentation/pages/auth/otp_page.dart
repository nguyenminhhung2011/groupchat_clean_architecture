import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(paddingAllWidget),
        child: SizedBox(
          height: 60.0,
          child: ButtonCustom(
            title: "Verify",
            color: darkPrimaryColor,
            textColor: textIconColor,
            onPress: () {},
            horizontal: 0.0,
          ),
        ),
      ),
      appBar: appBarWidget(
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: textIconColorGray,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        null,
        Text(
          'OTP Code Verification',
          style: headerText1.copyWith(
            fontSize: headerSizeText1,
          ),
        ),
        null,
      ),
      body: ListViewMain(
        children: [
          SizedBox(height: heightDevice / 4.5),
          FittedBox(
            fit: BoxFit.cover,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: horizontalAllSize * 2),
              child: Text(
                'Code has been send to +11*******99',
                style: headerText2.copyWith(
                  fontSize: middleSizeText,
                ),
              ),
            ),
          ),
          SizedBox(height: heightDevice / (4.6 * 6)),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalAllSize * 2),
            child: OTPCodeField(),
          ),
          SizedBox(height: heightDevice / (4.6 * 5)),
          Align(
            alignment: Alignment.center,
            child: RichText(
              text: TextSpan(
                style: headerText2.copyWith(fontSize: medumSizeText),
                children: [
                  const TextSpan(text: 'Resend conde in '),
                  TextSpan(
                    text: '55',
                    style: TextStyle(color: darkPrimaryColor),
                  ),
                  const TextSpan(text: ' s'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OTPCodeField extends StatefulWidget {
  const OTPCodeField({
    super.key,
  });

  @override
  State<OTPCodeField> createState() => _OTPCodeFieldState();
}

class _OTPCodeFieldState extends State<OTPCodeField> {
  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  late TextEditingController otp1;
  late TextEditingController otp2;
  late TextEditingController otp3;
  late TextEditingController otp4;
  late String otp_code = "";

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();

    otp1 = TextEditingController();
    otp2 = TextEditingController();
    otp3 = TextEditingController();
    otp4 = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    otp1.dispose();
    otp2.dispose();
    otp3.dispose();
    otp4.dispose();
    otp_code = "";

    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
  }

  void nextField({required String value, FocusNode? focuseNode}) {
    if (value.length == 1) {
      focuseNode?.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: otp1,
            autofocus: true,
            obscureText: true,
            style: headerText1.copyWith(fontSize: 24.0),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
            ),
            onChanged: (value) {
              nextField(value: value, focuseNode: pin2FocusNode);
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: otp2,
            obscureText: true,
            style: headerText1.copyWith(fontSize: 24.0),
            focusNode: pin2FocusNode,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
            ),
            onChanged: (value) {
              nextField(value: value, focuseNode: pin3FocusNode);
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: otp3,
            obscureText: true,
            focusNode: pin3FocusNode,
            style: headerText1.copyWith(fontSize: 24.0),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
            ),
            onChanged: (value) {
              nextField(value: value, focuseNode: pin4FocusNode);
            },
          ),
        ),
        const Spacer(),
        SizedBox(
          width: 60,
          child: TextFormField(
            controller: otp4,
            focusNode: pin4FocusNode,
            obscureText: true,
            style: headerText1.copyWith(fontSize: 24.0),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(color: darkPrimaryColor, width: 2),
              ),
            ),
            onChanged: (value) {
              pin4FocusNode.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
