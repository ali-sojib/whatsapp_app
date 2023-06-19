import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    //watch is like a internal bucket store all global variable
    return AuthController(authRepository: authRepository);
  },
);

class AuthController {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
  });

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
}
