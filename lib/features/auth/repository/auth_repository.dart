import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/common/utils/utils.dart';
import 'package:whatsapp_app/features/auth/screens/otp_screen.dart';

final authRepositoryProvider = Provider(
  (ref) => AuthRepository(
    auth: FirebaseAuth.instance,
    firestore: FirebaseFirestore.instance,
  ),
);

class AuthRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRepository({
    required this.auth,
    required this.firestore,
  });

  void signInWhithPhone(BuildContext context, String phoneNumber) async {
    try {
      await auth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            showSnackBar(context: context, content: 'verifyPhoneNumber');
            print(
                'verifyPhoneNumber rrrrrrrrrrvvvvvvvvvvvvvvvv verificationCompleted rrrrrrrrrrvvvvvvvvvvvvv');
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showSnackBar(context: context, content: 'verificationFailed');
            print(
                'verificationFailed rrrrrrrrrrvvvvvvvvvvvvvvvv verificationFailed rrrrrrrrrrvvvvvvvvvvvvv');
            print('print ${e.message}');
            throw Exception(e.message);
          },
          codeSent: ((String verificationId, int? resendingToken) async {
            showSnackBar(context: context, content: 'codeSent');
            print(
                'codeSent rrrrrrrrrvvvvvvvvvvvvvvvv codeSent rrrrrrrrrrvvvvvvvvvvvvv');
            Navigator.pushNamed(
              context,
              OTPScreen.routeName,
              arguments: verificationId,
            );
          }),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(
                'codeAutoRetrievalTimeout rrrrrrrrrrvvvvvvvvvvvvvvvv codeAutoRetrievalTimeout rrrrrrrrrrvvvvvvvvvvvvv');
            showSnackBar(context: context, content: 'codeAutoRetrievalTimeout');
          });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
}
