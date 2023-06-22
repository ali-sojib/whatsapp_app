import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_app/colors.dart';
import 'package:whatsapp_app/common/widgets/error.dart';
import 'package:whatsapp_app/common/widgets/loader.dart';
import 'package:whatsapp_app/features/auth/controller/auth_controller.dart';
import 'package:whatsapp_app/features/landing/screens/landing_screen.dart';
import 'package:whatsapp_app/firebase_options.dart';
import 'package:whatsapp_app/router.dart';
import 'package:whatsapp_app/screens/mobile_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Whatsapp UI',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: ref.watch(userDataAuthControllerProvider).when(
              data: (user) {
                if (user == null) {
                  return const LandingScreen();
                }
                return const MobileLayoutScreen();
              },
              error: (err, stackTrace) {
                return ErrorScreen(
                  error: err.toString(),
                );
              },
              loading: () => const Loader(),
            )
        // const ResponsiveLayout(
        //   mobileScreenLayout: MobileLayoutScreen(),
        //   webScreenLayout: WebLayoutScreen(),
        // ),
        );
  }
}
