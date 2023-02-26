import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/data/remote_data_source/storage_provider.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/single_chat_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/group/group_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/user/user_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/button_custom.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../../page_const.dart';
import '../../../domain/entities/user_entity.dart';
import '../../widgets/chat_item.dart';
import '../../widgets/dialog/create_group_dialog.dart';
import '../../widgets/main_page_option_item.dart';
import '../../widgets/person_acti_item.dart';
import '../../widgets/text_field_widget.dart';

class HomePage extends StatefulWidget {
  final String uid;
  const HomePage({super.key, required this.uid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _select = 0;

  List<Map<String, dynamic>> listOptionWidgets = [
    {
      'icon': Icons.message,
      'text': 'Doan Chat',
      'id': 0,
    },
    {
      'icon': Icons.delete,
      'text': 'Doan Chat Luu Tru',
      'id': 1,
    },
    {
      'icon': Icons.bar_chart_sharp,
      'text': 'Thong Ke',
      'id': 2,
    }
  ];
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    BlocProvider.of<GroupCubit>(context).getGroups();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return _bodyWidget(userState.users);
        }
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: CircularProgressIndicator(color: darkPrimaryColor),
          ),
        );
      },
    );
  }

  Scaffold _bodyWidget(List<UserEntity> users) {
    final currentUser = users.firstWhere((e) => e.uid == widget.uid);
    return Scaffold(
      floatingActionButton: IconButton(
        color: blueColor,
        hoverColor: blueColor,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              backgroundColor: Colors.transparent,
              child: CreateGroupDiallog(uid: currentUser.uid),
            ),
          );
        },
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: _drawerWidget(currentUser),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Chat',
          style: headerText1.copyWith(fontSize: headerSizeText - 12),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            borderRadius: BorderRadius.circular(20.0),
            onTap: () => _scaffoldKey.currentState?.openDrawer(),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey.withOpacity(0.2),
              ),
              child: Icon(
                Icons.list,
                color: textIconColorGray,
                size: 20.0,
              ),
            ),
          ),
        ),
        actions: [],
      ),
      body: ListViewMain(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: horizontalAllSize - 5, vertical: 10.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon:
                    Icon(Icons.search, color: Colors.grey.shade600, size: 20),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: const EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.grey.shade100,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: horizontalAllSize - 5.0),
              ...users.map((e) => e.uid != currentUser.uid
                  ? PersonAcityItem(
                      image: e.profileUrl,
                      name: e.name,
                      isActive: true,
                    )
                  : const SizedBox()),
            ],
          ),
          // const SizedBox(height: 10.0),
          const SizedBox(height: 10.0),
          ListGroupField(
            currentUser: currentUser,
          ),
        ],
      ),
    );
  }

  Drawer _drawerWidget(UserEntity currentUser) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: false,
          leading: Container(
            height: 40.0,
            width: 40.0,
            margin: const EdgeInsets.all(10.0),
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
          actions: [
            IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                PageConst.profilePage,
                arguments: widget.uid,
              ),
              icon: Icon(Icons.settings, color: textIconColorGray),
            ),
          ],
          title: Text(
            ' ${currentUser.name}',
            style: headerText1.copyWith(fontSize: medumSizeText),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(paddingAllWidget - 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...listOptionWidgets.map(
                (e) => MainPageOptionItem(
                  check: _select == e['id'],
                  icon: Icon(
                    e['icon'],
                    color: textIconColorGray,
                    size: 20.0,
                  ),
                  text: e['text'],
                  select: () {
                    setState(() {
                      _select = e['id'];
                    });
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cong dong',
                    style: headerText2.copyWith(
                      fontSize: medumSizeText,
                      color: color747480,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Text(
                      'Chinh Sua',
                      style: headerText1.copyWith(
                          fontSize: lowSizeText, color: blueColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  // ListViewMain _bodyWidget() {
  //   return
  // }
}

class ListGroupField extends StatelessWidget {
  final UserEntity currentUser;
  const ListGroupField({
    super.key,
    required this.currentUser,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupCubit, GroupState>(
      builder: (context, groupState) {
        if (groupState is GroupLoaded) {
          return Column(
            children: [
              ...groupState.groups.map(
                (e) => (e.uid == currentUser.uid)
                    ? ChatItem(
                        name: e.groupName,
                        url: e.groupProfileImage,
                        lastMess: {
                          'mess': e.lastMessage,
                          'time': DateTime.now(),
                        },
                        callback: () {
                          if (currentUser.uid == e.uid) {
                            BlocProvider.of<GroupCubit>(context)
                                .joinGroup(
                              groupEntity:
                                  GroupEntity(groupId: e.groupId, uid: e.uid),
                            )
                                .then((value) {
                              BlocProvider.of<GroupCubit>(context).getGroups();
                            });
                          }
                          Navigator.pushNamed(
                            context,
                            PageConst.singleChatPage,
                            arguments: SingleChatEntity(
                              username: currentUser.name,
                              groupId: e.groupId,
                              groupName: e.groupName,
                              uid: currentUser.uid,
                            ),
                          );
                        },
                      )
                    : const SizedBox(),
              )
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(color: darkPrimaryColor),
        );
      },
    );
  }
}
