import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  });
  final String? title;
  final double? width;
  final int? maxLine;
  final BorderSide? borderSide;
  final String? hint;
  final Widget? trailingIcon;
  final Widget? prefixWidget;
  final TextStyle? hintStyle;
  final bool? isPasswordField;
  final Function()? onTap;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? readOnly;
  final bool checkFormat;
  final bool? checkIconButton;
  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  RxBool isObscure = false.obs;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: Obx(
        () => TextFormField(
          readOnly: widget.readOnly ?? false,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: isObscure.value,
          maxLines: 1,
          inputFormatters: !widget.checkFormat
              ? [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]+[,.]{0,1}[0-9]*'))
                ]
              : [],
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            labelText: widget.title,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
            hintText: widget.hint,
            hintStyle: widget.hintStyle ??
                TextStyle(
                    color: Colors.grey[350]!,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
            border: OutlineInputBorder(
              // borderRadius: AppDecoration.primaryRadiusBorder,
              borderSide: widget.borderSide ??
                  BorderSide(color: Colors.grey[350]!, width: 0.4),
            ),
            suffixIcon: SizedBox(
              height: 50,
              width: 50,
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
                child: widget.trailingIcon,
              ),
            ),
            prefixIcon: widget.prefixWidget,
          ),
        ),
      ),
    );
  }
}
