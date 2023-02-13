import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';

class TextFieldWidget extends StatefulWidget {
  const TextFieldWidget({
    super.key,
    this.title,
    this.maxLine,
    this.trailingIcon,
    this.hint,
    this.prefixWidget,
    this.width,
    this.hintStyle,
    this.borderSide,
    this.isPasswordField,
    this.controller,
    this.validator,
    this.onTap,
    this.readOnly,
    this.checkFormat = true,
    this.checkIconButton = false,
    this.horizontal,
  });
  final String? title;
  final double? width;
  final int? maxLine;
  final BorderSide? borderSide;
  final String? hint;
  final IconData? trailingIcon;
  final Widget? prefixWidget;
  final TextStyle? hintStyle;
  final bool? isPasswordField;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool checkFormat;
  final bool? checkIconButton;
  final double? horizontal;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  RxBool isObscure = false.obs;
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
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalAllSize, vertical: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
            width: 1,
            color: _focus.hasFocus ? purpleColor : Colors.transparent),
        color: _focus.hasFocus ? purpleColor.withOpacity(0.1) : colorC1C1C2,
      ),
      width: widget.width ?? double.infinity,
      child: Obx(
        () => TextFormField(
          focusNode: _focus,
          readOnly: widget.readOnly ?? false,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: isObscure.value,
          maxLines: 1,
          inputFormatters: !widget.checkFormat
              ? [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[0-9]+[,.]{0,1}[0-9]*'),
                  )
                ]
              : [],
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.title,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                headerText3.copyWith(
                  color: colorC1C1C1,
                  fontSize: middleSizeText,
                ),
            border: InputBorder.none,
            suffixIcon: SizedBox(
              height: 30,
              width: 30,
              child: InkWell(
                onTap: () {
                  if (widget.isPasswordField ?? false) {
                    isObscure.value = !isObscure.value;
                  } else {
                    if (widget.checkIconButton!) {
                      widget.onTap!();
                    }
                  }
                },
                child: widget.trailingIcon != null
                    ? Icon(widget.trailingIcon,
                        color: _focus.hasFocus ? purpleColor : Colors.grey)
                    : (isObscure.value
                        ? Icon(Icons.visibility,
                            color: _focus.hasFocus ? purpleColor : Colors.grey)
                        : Icon(Icons.visibility_off,
                            color:
                                _focus.hasFocus ? purpleColor : Colors.grey)),
              ),
            ),
            prefixIcon: widget.prefixWidget,
          ),
        ),
      ),
    );
  }
}
