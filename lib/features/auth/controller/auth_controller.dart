import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/features/auth/repository/auth_repository.dart';
import 'package:whatsapp_app/model/user_model.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    //watch is like a internal bucket store all global variable
    return AuthController(authRepository: authRepository, ref: ref);
  },
);

final userDataAuthControllerProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getUserDataCtr();
});

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;
  AuthController({
    required this.authRepository,
    required this.ref,
  });

  Future<UserModel?> getUserDataCtr() async {
    UserModel? user = await authRepository.getCurrentUserData();
    return user;
  }

  void signInWhithPhoneInCrt(BuildContext context, String phoneNumber) {
    authRepository.signInWhithPhone(context, phoneNumber);
  }

  void verifyOTPInCtr(
      BuildContext context, String verificationId, String userOTP) {
    authRepository.verifyOTP(
      context: context,
      verificationId: verificationId,
      userOTP: userOTP,
    );
  }

  void saveUserDataToFirebase(
      BuildContext context, String name, File? profilePic) {
    authRepository.saveUserDataToFirebase(
      name: name,
      profilePic: profilePic,
      ref: ref,
      context: context,
    );
  }

  Stream<UserModel> userDataCtr(String userId) {
    return authRepository.userData(userId);
  }
}
