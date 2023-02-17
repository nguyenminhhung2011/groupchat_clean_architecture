import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/storage_provider.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/phone_number_field_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/text_field_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../page_const.dart';
import '../../../domain/entities/user_entity.dart';
import '../../cubit/user/user_cubit.dart';
import '../../widgets/option_setting_item.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _nameController = TextEditingController();
  final _statusController = TextEditingController();
  final _phoneNoController = TextEditingController();
  final _oldPasswordController = TextEditingController();
  final _rePasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();

  // ignore: prefer_final_fields
  List<TextEditingController> _listTextController = [
    for (int i = 0; i < 3; i++) TextEditingController()
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Map<String, dynamic>> listOptions = [
    {
      'leadTitle': 'Che do toi',
      'title': 'Tat',
      'color': Colors.black,
      'icon': Icons.dark_mode,
    },
    {
      'leadTitle': 'Trang  thai hoat dong',
      'title': 'Dang bat',
      'color': const Color.fromARGB(255, 120, 251, 124),
      'icon': Icons.local_activity_rounded,
    },
    {
      'leadTitle': 'Ten nguoi dung',
      'title': 'Minh Hung',
      'color': Colors.red,
      'icon': Icons.near_me,
    }
  ];

  File? _file;
  final picker = ImagePicker();
  String url = "";

  Future getImage() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _file = File(pickedFile.path);
          StorageProviderRemoteDataSource.upLoadFile(file: _file!)
              .then((value) {
            print(value);
            _updateAvata(value);
            setState(() {
              url = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  void dispose() {
    for (var item in _listTextController) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _bodyWidget(context, userState.users);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(color: primaryColor),
          ),
        );
      },
    );
  }

  Scaffold _bodyWidget(BuildContext context, List<UserEntity> users) {
    final currentUser =
        users.firstWhere((element) => element.uid == widget.uid);

    _nameController.text = currentUser.name;
    _statusController.text = currentUser.status;
    return Scaffold(
      key: _scaffoldKey,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(paddingAllWidget),
        child: SizedBox(
          height: 50.0,
          child: ButtonCustom(
            title: "Sign Out",
            color: Colors.red,
            textColor: textIconColor,
            onPress: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, PageConst.loginPage, (route) => false);
            },
            horizontal: 0.0,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: appBarWidget(
        IconButton(
          icon: Icon(Icons.arrow_back, color: textIconColorGray),
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
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        url != ""
                            ? url
                            : currentUser.profileUrl == ""
                                ? 'https://sbcf.fr/wp-content/uploads/2018/03/sbcf-default-avatar.png'
                                : currentUser.profileUrl,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 60.0,
                  top: 60.0,
                  child: InkWell(
                    onTap: () {
                      getImage();
                    },
                    child: Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 5.0, color: Colors.white),
                        color: Colors.grey.withOpacity(0.8),
                      ),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        color: textIconColorGray,
                        size: 16.0,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Align(
            alignment: Alignment.center,
            child: Text(
              currentUser.name,
              style: headerText1.copyWith(fontSize: headerSizeText - 12),
            ),
          ),
          const SizedBox(height: 20.0),
          ...listOptions.map(
            (e) => OptionSettingItem(
              icon: Icon(
                e['icon'],
                color: Colors.white,
                size: 16.0,
              ),
              color: e['color'],
              leadTitle: e['leadTitle'],
              title: e['title'],
              select: () {},
            ),
          ),
          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: horizontalAllSize),
            child: Text(
              'Thong tin ca nhan',
              style: headerText1.copyWith(
                fontSize: medumSizeText,
                color: color747480,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          OptionSettingItem(
            color: Colors.blue,
            icon: const Icon(Icons.person, color: Colors.white, size: 16.0),
            leadTitle: 'Thong tin',
            title: 'Minh Hung',
            select: () async {
              await _updateUserDialog(context);
            },
          ),
          OptionSettingItem(
            color: darkPrimaryColor,
            icon: const Icon(Icons.key, color: Colors.white, size: 16.0),
            leadTitle: 'Mat Khau',
            title: '********',
            select: () async {
              await _changePasswordDialog(context, currentUser);
            },
          ),
        ],
      ),
    );
  }

  Future<dynamic> _changePasswordDialog(
      BuildContext context, UserEntity currentUser) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(paddingAllWidget),
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
                controller: _oldPasswordController,
                horizontal: 5.0,
                isPasswordField: true,
                hint: "Enter your password",
              ),
              const SizedBox(height: 10.0),
              TextFieldWidget(
                controller: _newPasswordController,
                horizontal: 5.0,
                isPasswordField: true,
                hint: "Enter new password",
              ),
              const SizedBox(height: 10.0),
              TextFieldWidget(
                controller: _rePasswordController,
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
                onPress: () {
                  _changePassword(currentUser);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _updateUserDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(paddingAllWidget),
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
                controller: _nameController,
                isPasswordField: false,
                trailingIcon: Icons.person,
                horizontal: 5,
              ),
              const SizedBox(height: 10.0),
              TextFieldWidget(
                controller: _statusController,
                isPasswordField: false,
                trailingIcon: Icons.description,
                horizontal: 5,
              ),
              const SizedBox(height: 10.0),
              PhoneNumberFieldWidget(
                controller: _phoneNoController,
                horizontal: 5.0,
              ),
              const SizedBox(height: 15.0),
              ButtonCustom(
                title: 'Update',
                color: darkPrimaryColor,
                horizontal: 5.0,
                textColor: textIconColor,
                onPress: _updateUser,
              )
            ],
          ),
        ),
      ),
    );
  }

  void _updateAvata(String value) {
    BlocProvider.of<UserCubit>(context)
        .updateAvata(profileUrl: value, uid: widget.uid);
  }

  void _updateUser() {
    BlocProvider.of<UserCubit>(context).updateUser(
      user: UserEntity(
        name: _nameController.text,
        phoneNumber: _phoneNoController.text,
        status: _statusController.text,
      ),
    );
  }

  void _changePassword(UserEntity currentUser) {
    // if (_oldPasswordController.text != currentUser.password) {
    //   return;
    // }
    // if (_newPasswordController.text.length < 8) {
    //   return;
    // }
    // if (_newPasswordController.text != _rePasswordController.text) {
    //   return;
    // }
    BlocProvider.of<UserCubit>(context)
        .changePassword(newPassword: _newPasswordController.text);
  }
}
