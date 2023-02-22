import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/group_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/single_chat_entity.dart';
import 'package:groupchat_clean_architecture/features/domain/entities/text_message_entity.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/chat/chat_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/cubit/group/group_cubit.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/style.dart';
import 'package:groupchat_clean_architecture/features/presentation/widgets/theme/template.dart';

import '../../widgets/rec_card.dart';
import '../../widgets/send_card.dart';
// import 'package:bubble/bubble.dart';s

class SingleChatPage extends StatefulWidget {
  final SingleChatEntity singleChatEntity;
  const SingleChatPage({super.key, required this.singleChatEntity});

  @override
  State<SingleChatPage> createState() => _SingleChatPageState();
}

class _SingleChatPageState extends State<SingleChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _messageController.addListener(() {
      setState(() {});
    });
    BlocProvider.of<ChatCubit>(context)
        .getMessages(channelId: widget.singleChatEntity.groupId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.singleChatEntity.groupName),
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, chatState) {
          if (chatState is ChatLoaded) {
            return Column(
              children: [
                const SizedBox(height: 10.0),
                _listMessage(chatState),
                _messgeField(),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Expanded _listMessage(ChatLoaded message) {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        controller: _scrollController,
        itemCount: message.chats.length,
        itemBuilder: (_, index) {
          if (message.chats[index].senderId == widget.singleChatEntity.uid) {
            return SendCard(
              title: message.chats[index].content!,
              check: true,
              typeMess: message.chats[index].type! == "TEXT" ? 0 : 1,
              imageMess: "",
              time: DateTime.fromMicrosecondsSinceEpoch(
                  message.chats[index].time!.microsecondsSinceEpoch),
            );
          } else {
            return RecCard(
              time: DateTime.fromMicrosecondsSinceEpoch(
                  message.chats[index].time!.microsecondsSinceEpoch),
              title: message.chats[index].content!,
              avt: "",
              check: true,
              typeMess: message.chats[index].type! == "TEXT" ? 0 : 1,
              imageMess: "",
            );
          }
        },
      ),
    );
  }

  Widget _messgeField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(
          left: paddingAllWidget,
          right: paddingAllWidget,
          bottom: paddingAllWidget),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 10.0)],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: "Send Message...",
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (_messageController.text.isEmpty) {
                //TODO
              } else {
                BlocProvider.of<ChatCubit>(context).sendMessage(
                  textMessageEntity: TextMessageEntity(
                    time: Timestamp.now(),
                    senderId: widget.singleChatEntity.uid,
                    content: _messageController.text,
                    senderName: widget.singleChatEntity.username,
                    type: "TEXT",
                  ),
                  channelId: widget.singleChatEntity.groupId,
                );
                BlocProvider.of<GroupCubit>(context).updateGroup(
                  groupEntity: GroupEntity(
                    lastMessage: _messageController.text,
                    groupId: widget.singleChatEntity.groupId,
                    creationTime: Timestamp.now(),
                  ),
                );
                _messageController.clear();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(paddingAllWidget - 5),
              decoration: const BoxDecoration(
                color: blueColor,
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)],
              ),
              child: Icon(Icons.send, color: textIconColor, size: 14.0),
            ),
          ),
        ],
      ),
    );
  }
}
