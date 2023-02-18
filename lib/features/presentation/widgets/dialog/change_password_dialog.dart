import 'package:flutter/material.dart';

import '../../../domain/entities/user_entity.dart';
import '../../pages/home/profile_page.dart';
import '../button_custom.dart';
import '../phone_number_field_widget.dart';
import '../text_field_widget.dart';
import '../theme/style.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    super.key,
    required TextEditingController oldPasswordController,
    required TextEditingController newPasswordController,
    required TextEditingController rePasswordController,
    required this.currentUser,
  })  : _oldPasswordController = oldPasswordController,
        _newPasswordController = newPasswordController,
        _rePasswordController = rePasswordController;

  final TextEditingController _oldPasswordController;
  final TextEditingController _newPasswordController;
  final TextEditingController _rePasswordController;
  final UserEntity currentUser;

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(paddingAllWidget - 5.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: textIconColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Thay doi mat khau',
              style: headerText1.copyWith(fontSize: headerSizeText1),
            ),
            const SizedBox(height: 20.0),
            TextFieldWidget(
              controller: widget._oldPasswordController,
              horizontal: 5.0,
              isPasswordField: true,
              hint: "Enter your password",
            ),
            const SizedBox(height: 10.0),
            TextFieldWidget(
              controller: widget._newPasswordController,
              horizontal: 5.0,
              isPasswordField: true,
              hint: "Enter new password",
            ),
            const SizedBox(height: 10.0),
            TextFieldWidget(
              controller: widget._rePasswordController,
              horizontal: 5.0,
              isPasswordField: true,
              hint: "Enter re password",
            ),
            const SizedBox(height: 15.0),
            ButtonCustom(
              title: 'Update',
              color: darkPrimaryColor,
              horizontal: 5.0,
              textColor: textIconColor,
              circle: _isSelect,
              onPress: () {
                setState(() {
                  _isSelect = true;
                });
                HandleProfileFunction.changePassword(
                  widget.currentUser,
                  context,
                  widget._newPasswordController.text,
                  widget._oldPasswordController.text,
                  widget._rePasswordController.text,
                );
                setState(() {
                  _isSelect = false;
                });
                Navigator.pop(context);
              },
            )
          ],
        ),
      ),
    );
  }
}
