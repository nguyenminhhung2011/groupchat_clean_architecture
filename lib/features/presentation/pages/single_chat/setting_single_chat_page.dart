import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/group/group_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/app_bar_widget.dart';
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
        const SizedBox(height: 10),
      ],
    );
  }
}
