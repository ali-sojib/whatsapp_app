import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:whatsapp_app/common/utils/utils.dart';
import 'package:whatsapp_app/model/user_model.dart';

class ChatRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  ChatRepository({
    required this.firestore,
    required this.auth,
  });

  void sendTextMessage({
    required BuildContext context,
    required String text,
    required String recieverUserId,
    required UserModel senderUser,
  }) async {
    //user -> sender Id -> recever Id -> messages -> massages Id -> store massages
    try {
      var timeSent = DateTime.now();
      UserModel receverUserData;

      var userDataMap =
          await firestore.collection('user').doc(recieverUserId).get();

      receverUserData = UserModel.fromMap(userDataMap.data()!);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }
}
