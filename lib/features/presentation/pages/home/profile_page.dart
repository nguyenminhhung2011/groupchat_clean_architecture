import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../domain/entities/user_entity.dart';
import '../../cubit/user/user_cubit.dart';

class ProfilePage extends StatefulWidget {
  final String uid;
  const ProfilePage({super.key, required this.uid});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future getImage() async {
    try {
      // ignore: deprecated_member_use
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      setState(() {
        if (pickedFile != null) {
          _file = File(pickedFile.path);

          // StorageProviderRemoteDataSource.uploadFile(file: _image!)
          //     .then((value) {
          //   print("profileUrl");
          //   setState(() {
          //     _profileUrl = value;
          //   });
          // });
        } else {
          print('No image selected.');
        }
      });
    } catch (error) {
      print(error);
    }
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
    return Scaffold(
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
                        currentUser.profileUrl == ""
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
              'Dich Vu',
              style: headerText1.copyWith(
                fontSize: medumSizeText,
                color: color747480,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class OptionSettingItem extends StatelessWidget {
  final Color color;
  final Widget icon;
  final String leadTitle;
  final String title;
  final VoidCallback select;
  const OptionSettingItem({
    super.key,
    required this.color,
    required this.icon,
    required this.leadTitle,
    required this.title,
    required this.select,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: horizontalAllSize, vertical: 10.0),
      child: InkWell(
        onTap: select,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 35.0,
              height: 35.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              child: icon,
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  leadTitle,
                  style: headerText2.copyWith(fontSize: medumSizeText),
                ),
                Text(
                  title,
                  style: headerText2.copyWith(fontSize: lowSizeText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
