import 'package:flutter/material.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

import '../../../generated/assets..dart';

class PhoneNumberFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final double? horizontal;
  const PhoneNumberFieldWidget(
      {super.key, required this.controller, this.horizontal});

  @override
  State<PhoneNumberFieldWidget> createState() => _PhoneNumberFieldWidgetState();
}

class _PhoneNumberFieldWidgetState extends State<PhoneNumberFieldWidget> {
  FocusNode _focus = FocusNode();
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
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: widget.horizontal ?? horizontalAllSize,
      ),
      padding: const EdgeInsets.all(paddingAllWidget - 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
            width: 1,
            color: _focus.hasFocus ? purpleColor : Colors.transparent),
        color: _focus.hasFocus ? purpleColor.withOpacity(0.1) : colorC1C1C2,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {},
            child: Row(
              children: [
                Image.asset(Assets.appIconAssets, height: 35.0, width: 35.0),
                Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: middleSizeText,
                  color: _focus.hasFocus ? purpleColor : colorC1C1C1,
                )
              ],
            ),
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: TextField(
              focusNode: _focus,
              controller: widget.controller,
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
    );
  }
}
