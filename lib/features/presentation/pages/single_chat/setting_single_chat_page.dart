import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/api_remote_data_source_impl.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/user_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/group/group_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/user/user_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/text_field_widget.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/remote_data_source/storage_provider.dart';
import '../../../domain/entities/group_entity.dart';
import '../../widgets/profille_widget.dart';
import '../../widgets/theme/style.dart';

class SettingSingleChatPage extends StatefulWidget {
  final String groupId;
  const SettingSingleChatPage({super.key, required this.groupId});

  @override
  State<SettingSingleChatPage> createState() => _SettingSingleChatPageState();
}

class _SettingSingleChatPageState extends State<SettingSingleChatPage> {
  final TextEditingController _nameGroupController = TextEditingController();
  List<dynamic> listMembers = [];
  File? _image;
  String? _groupUrl;

  Future getImage() async {
    try {
      final pickedFile =
          await ImagePicker.platform.getImage(source: ImageSource.gallery);

      setState(() {
        if (pickedFile != null) {
          _image = File(pickedFile.path);

          StorageProviderRemoteDataSource.upLoadFile(file: _image!)
              .then((value) {
            print("profileUrl");
            setState(() {
              _groupUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (_) {}
  }

  @override
  void initState() {
    getMembers();
    super.initState();
  }

  void getMembers() async {
    await FirebaseFirestore.instance
        .collection('groupChatChannel')
        .snapshots()
        .map(
          (querySnapshot) => querySnapshot.docs
              .map((e) =>
                  {'members': e.get('members'), 'id': e.get('groupChannelId')})
              .toList(),
        )
        .listen((event) {
      for (var item in event) {
        print(item);
        if (item['id'] == widget.groupId) {
          listMembers = item['members'];
          break;
        }
      }
    });
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBarWidget(
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          null,
          const Text('Edit Group'),
          Colors.transparent),
      body: BlocBuilder<GroupCubit, GroupState>(
        builder: (context, groupState) {
          if (groupState is GroupLoaded) {
            return _bodyWidget(widthDevice, groupState.groups);
          }
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: CircularProgressIndicator(color: blueColor),
            ),
          );
        },
      ),
    );
  }

  ListViewMain _bodyWidget(double widthDevice, List<GroupEntity> groups) {
    final GroupEntity currentGroup =
        groups.firstWhere((element) => element.groupId == widget.groupId);
    _groupUrl = currentGroup.groupProfileImage;
    _nameGroupController.text = currentGroup.groupName;
    return ListViewMain(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Container(
                height: widthDevice / 3,
                width: widthDevice / 3,
                decoration: BoxDecoration(
                  color: color747480,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(100.0),
                  ),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10.0)
                  ],
                ),
                child: ClipOval(
                  child: profileWidget(
                    image: _image,
                    imageUrl: _groupUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        TextFieldWidget(
          controller: _nameGroupController,
          trailingIcon: Icons.people,
        ),
        const SizedBox(height: 20.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: paddingAllWidget),
          child: Row(
            children: [
              Text('Group member',
                  style: headerText2.copyWith(fontSize: medumSizeText)),
              const Spacer(),
              InkWell(
                onTap: () {},
                child: Text(
                  'Add member',
                  style: headerText2.copyWith(
                      fontSize: lowSizeText, color: blueColor),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        BlocBuilder<UserCubit, UserState>(
          builder: (context, userState) {
            if (userState is UserLoaded) {
              // var result = {for (var item in userState.users) item.uid: item};
              return _listMemberField({});
            } else {
              return const SizedBox();
            }
          },
        )
      ],
    );
  }

  Widget _listMemberField(Map<String, UserEntity> users) {
    return Column(
      children: [
        for (var item in listMembers)
          Row(
            children: [Text(users[item.toString()]!.name)],
          ),
      ],
    );
  }
}
