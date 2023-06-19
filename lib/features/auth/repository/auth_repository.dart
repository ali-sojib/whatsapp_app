import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/common/utils/utils.dart';
import 'package:whatsapp_app/features/auth/screens/otp_screen.dart';
import 'package:whatsapp_app/features/auth/screens/user_information_screen.dart';

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
            await auth.signInWithCredential(credential);
          },
          verificationFailed: (e) {
            showSnackBar(context: context, content: 'verificationFailed');
            print('print ${e.message}');
            throw Exception(e.message);
          },
          codeSent: ((String verificationId, int? resendingToken) async {
            showSnackBar(context: context, content: 'codeSent');
            Navigator.pushNamed(
              context,
              OTPScreen.routeName,
              arguments: verificationId,
            );
          }),
          codeAutoRetrievalTimeout: (String verificationId) {
            showSnackBar(context: context, content: 'codeAutoRetrievalTimeout');
          });
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }

  void verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String userOTP,
  }) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: userOTP,
      );
      print('inside inside insideverifyOTPinside inside inside ');
      await auth.signInWithCredential(credential);
      //my own line of ignore
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
        context,
        UserInformationScreen.routeName,
        (route) => false,
      );
    } on FirebaseAuthException catch (e) {
      showSnackBar(context: context, content: e.message!);
    }
  }
}
