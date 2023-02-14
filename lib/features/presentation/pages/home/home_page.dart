import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/auth/auth_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/user/user_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';
import 'package:intl/intl.dart';

import '../../../../page_const.dart';
import '../../../domain/entities/user_entity.dart';
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

  List<Widget> listPersonActi = const [
    PersonAcityItem(
        image: 'assets/images/hoang.png',
        name: 'Truong Huynh Duc Hoang',
        isActive: true),
    PersonAcityItem(
        image: 'assets/images/face.png',
        name: 'Nguyen Minh Hung',
        isActive: true),
    PersonAcityItem(
        name: 'Ngo Mai Quoc Thang',
        image: 'assets/images/app_icon.png',
        isActive: true),
    PersonAcityItem(
        image: 'assets/images/google.png',
        name: 'Vo Dang Thien Khai',
        isActive: true),
    PersonAcityItem(
        image: 'assets/images/gmail.png',
        name: 'Nguyen Thanh Tung',
        isActive: true),
  ];
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final widthDevice = MediaQuery.of(context).size.width;
    // final heightDevice = MediaQuery.of(context).size.height;
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
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: false,
            leading: Container(
              height: 40.0,
              width: 40.0,
              margin: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
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
            padding: const EdgeInsets.all(paddingAllWidget),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [],
                ),
              ],
            ),
          ),
        ),
      ),
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
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
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
              ...listPersonActi.map((e) => e),
            ],
          ),
          const SizedBox(height: 10.0),
          ChatItem(
            name: 'Nguyen Minh Hung',
            url: 'assets/images/face.png',
            lastMess: {
              'mess': 'Hello nice to meet you',
              'time': DateTime.now(),
            },
          ),
        ],
      ),
    );
  }

  // ListViewMain _bodyWidget() {
  //   return
  // }
}

class ChatItem extends StatelessWidget {
  final String name;
  final String url;
  final Map<String, dynamic> lastMess;
  const ChatItem({
    super.key,
    required this.name,
    required this.url,
    required this.lastMess,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: horizontalAllSize - 5.0),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(url),
                  ),
                ),
              ),
              Positioned(
                top: 45.0,
                left: 45,
                child: Container(
                  width: 15.0,
                  height: 15.0,
                  decoration: BoxDecoration(
                    border: Border.all(width: 2.0, color: Colors.white),
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: headerText1.copyWith(fontSize: medumSizeText),
                  maxLines: 1,
                ),
                const SizedBox(height: 2.0),
                Text(
                  lastMess['mess'],
                  style: headerText2.copyWith(
                    fontSize: lowSizeText,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat().add_jm().format(lastMess['time']),
              style: headerText1.copyWith(
                  fontSize: lowSizeText, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}

class PersonAcityItem extends StatelessWidget {
  final String image;
  final String name;
  final bool isActive;

  const PersonAcityItem({
    super.key,
    required this.image,
    required this.name,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 60.0,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: 48.0,
                  height: 48.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(image),
                    ),
                  ),
                ),
                Positioned(
                  top: 33.0,
                  left: 33,
                  child: Container(
                    width: 15.0,
                    height: 15.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.white),
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2.0),
            Text(
              name,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: headerText2.copyWith(fontSize: lowSizeText),
            ),
          ],
        ),
      ),
    );
  }
}
