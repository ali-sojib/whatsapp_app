import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/common/utils/utils.dart';
import 'package:whatsapp_app/model/user_model.dart';
import 'package:whatsapp_app/screens/mobile_chat_screen.dart';

final selectContactRepositoryProvider = Provider(
  (ref) => SelectContactRepository(
    firestore: FirebaseFirestore.instance,
  ),
);

class SelectContactRepository {
  final FirebaseFirestore firestore;
  String primaryNumber = '';

  SelectContactRepository({
    required this.firestore,
  });

  //getting permission from usr to display contacts
  Future<List<Contact>> getContacts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectedContact, BuildContext context) async {
    try {
      var userCollection = await firestore.collection('user').get();
      bool isFound = false;

      for (var document in userCollection.docs) {
        var userData = UserModel.fromMap(document.data());
        primaryNumber = selectedContact.phones[0].number;

        contactNumberFormater(primaryNumber);

        if (primaryNumber == userData.phoneNumber) {
          isFound = true;
          print('formattedNumber == userData.phoneNumber isFound true');

          // ignore: use_build_context_synchronously
          Navigator.pushNamed(context, MobileChatScreen.routeName, arguments: {
            'name': userData.name,
            'uid': userData.uid,
          });
        }

        print('phone number clicked = ${selectedContact.phones[0].number}');
      }

      if (!isFound) {
        showSnackBar(
          context: context,
          content: "This number did not dwonload this app",
        );
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void contactNumberFormater(String number) {
    //to removing extra '-' and 'spaces'
    String phoneNumber = number;

    RegExp regExp =
        RegExp(r'[^\d+]'); // Matches all non-digit characters except '+'

    String formattedNumber = phoneNumber.replaceAll(regExp, '');

    //adding bd country code which nubmer starting wih 01
    if (formattedNumber.startsWith('01')) {
      formattedNumber = '+88$formattedNumber';
    }

    primaryNumber = formattedNumber;

    print('contactNumberFormater =' + primaryNumber);
  }
}
