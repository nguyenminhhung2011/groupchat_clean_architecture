import 'package:flutter/material.dart';

import '../../pages/home/profile_page.dart';
import '../button_custom.dart';
import '../phone_number_field_widget.dart';
import '../text_field_widget.dart';
import '../theme/style.dart';

class UpdateUserDialog extends StatefulWidget {
  const UpdateUserDialog({
    super.key,
    required TextEditingController nameController,
    required TextEditingController statusController,
    required TextEditingController phoneNoController,
    required this.uid,
  })  : _nameController = nameController,
        _statusController = statusController,
        _phoneNoController = phoneNoController;

  final TextEditingController _nameController;
  final TextEditingController _statusController;
  final TextEditingController _phoneNoController;
  final String uid;

  @override
  State<UpdateUserDialog> createState() => _UpdateUserDialogState();
}

class _UpdateUserDialogState extends State<UpdateUserDialog> {
  bool _isSelect = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(paddingAllWidget - 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Chinh Sua thong tin',
              style: headerText1.copyWith(fontSize: headerSizeText1),
            ),
            const SizedBox(height: 20.0),
            TextFieldWidget(
              controller: widget._nameController,
              isPasswordField: false,
              trailingIcon: Icons.person,
              horizontal: 5,
            ),
            const SizedBox(height: 10.0),
            TextFieldWidget(
              controller: widget._statusController,
              isPasswordField: false,
              trailingIcon: Icons.description,
              horizontal: 5,
            ),
            const SizedBox(height: 10.0),
            PhoneNumberFieldWidget(
              controller: widget._phoneNoController,
              horizontal: 5.0,
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
                HandleProfileFunction.updateUser(
                  context,
                  widget._nameController.text,
                  widget._phoneNoController.text,
                  widget._statusController.text,
                  () {},
                  widget.uid,
                );
                Navigator.pop(context);
                setState(() {
                  _isSelect = false;
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
