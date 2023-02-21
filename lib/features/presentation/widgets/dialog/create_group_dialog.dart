import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/remote_data_source/storage_provider.dart';
import '../../../domain/entities/group_entity.dart';
import '../../cubit/group/group_cubit.dart';
import '../button_custom.dart';
import '../profille_widget.dart';
import '../text_field_widget.dart';
import '../theme/style.dart';
import '../theme/template.dart';

class CreateGroupDiallog extends StatefulWidget {
  final String uid;
  const CreateGroupDiallog({
    super.key,
    required this.uid,
  });

  @override
  State<CreateGroupDiallog> createState() => _CreateGroupDiallogState();
}

class _CreateGroupDiallogState extends State<CreateGroupDiallog> {
  final TextEditingController _groupNameController = TextEditingController();
  final TextEditingController _numberUserJoinController =
      TextEditingController();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File? _image;
  String? _profileUrl;

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
              _profileUrl = value;
            });
          });
        } else {
          print('No image selected.');
        }
      });
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: _scaffoldKey,
      // padding: const EdgeInsets.all(paddingAllWidget - 5.0),
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white,
      ),
      child: ListViewMain(
        children: [
          const SizedBox(height: paddingAllWidget),
          Text(
            'Create new Group',
            textAlign: TextAlign.center,
            style: headerText1.copyWith(
              fontSize: headerSizeText1,
              color: textIconColorGray,
            ),
          ),
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  getImage();
                },
                child: Container(
                  height: 80.0,
                  width: 80.0,
                  decoration: BoxDecoration(
                      color: color747480,
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0))),
                  child: ClipOval(
                    child: profileWidget(
                      image: _image,
                      imageUrl: _profileUrl,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          TextFieldWidget(
            hint: "Enter name of Group",
            trailingIcon: Icons.people,
            controller: _groupNameController,
          ),
          const SizedBox(height: 10.0),
          TextFieldWidget(
            hint: "Enter number of Group",
            trailingIcon: Icons.people,
            controller: _numberUserJoinController,
          ),
          const SizedBox(height: 15.0),
          const Divider(thickness: 1),
          const SizedBox(height: 15.0),
          ButtonCustom(
            title: "Create Group",
            color: darkPrimaryColor,
            textColor: textIconColor,
            onPress: _create,
          ),
        ],
      ),
    );
  }

  _create() {
    if (_image == null) {
      return;
    }
    if (_groupNameController.text.isEmpty) {
      return;
    }
    if (_numberUserJoinController.text.isEmpty) {
      return;
    }
    BlocProvider.of<GroupCubit>(context)
        .getCreateGroup(
      groupEntity: GroupEntity(
        lastMessage: "",
        uid: widget.uid,
        groupName: _groupNameController.text,
        creationTime: Timestamp.now(),
        groupProfileImage: _profileUrl!,
        joinUsers: "0",
        limitUsers: _numberUserJoinController.text,
      ),
    )
        .then((value) {
      // if(value.)s
      Navigator.pop(context);
    });
  }
}
