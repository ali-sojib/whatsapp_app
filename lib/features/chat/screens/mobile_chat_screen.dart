import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/colors.dart';
import 'package:whatsapp_app/common/widgets/loader.dart';
import 'package:whatsapp_app/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_app/info.dart';
import 'package:whatsapp_app/model/user_model.dart';
import 'package:whatsapp_app/widgets/chat_list.dart';

import '../widgets/bottom_filed_chat.dart';

class MobileChatScreen extends ConsumerWidget {
  static const routeName = '/mobile-chat-screen';
  final String name;
  final String uid;
  const MobileChatScreen({
    Key? key,
    required this.name,
    required this.uid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appBarColor,
        //using stramBuilder to upadte ui immediately
        title: StreamBuilder<UserModel>(
            //using auth crt funtion which link to repository funciton
            stream: ref.read(authControllerProvider).userDataCtr(uid),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loader();
              }
              return Column(
                children: [
                  Text(name),
                  Text(
                    snapshot.data!.isOnline ? 'online' : 'ofline',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(
            child: ChatList(),
          ),
          BottomChatField(),
        ],
      ),
    );
  }
}
