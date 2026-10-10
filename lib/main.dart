import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:payment_app/home/app_model.dart';
import 'package:payment_app/category/category_model.dart';
import 'package:payment_app/utils/color_page.dart';
import 'package:payment_app/home/home_screen.dart';
import 'package:payment_app/local_storage.dart';
import 'package:payment_app/auth/login_page.dart';
import 'package:payment_app/onboarding/slider_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:payment_app/start_page.dart';

import 'main_screen.dart';

// import 'package:payment_app/profile_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(AppModelAdapter());
  Hive.registerAdapter(CategoryModelAdapter());
  await Hive.openBox<AppModel>('app');
  await Hive.openBox<CategoryModel>('category');

  final seenOnboarding = await LocalStorage.getOnboarding();
  final isLoggedIn = await LocalStorage.getLogin();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    MyApp(
      seenOnboarding: seenOnboarding,
      isLoggedIn: isLoggedIn,
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;
  final bool isLoggedIn;

  const MyApp({
    super.key,
    required this.seenOnboarding,
    required this.isLoggedIn,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: UIColor.blackColor),
      ),
      home: !seenOnboarding
          ? StartPage()
          : !isLoggedIn
          ? LoginPage()
          : MainScreen(),
    );
  }
}
// 💡 What you should focus on (IMPORTANT for your issue)
//
// Since Firebase Dynamic Links are deprecated, search inside videos for:
//
// 🔍 Must learn topics:
// sendPasswordResetEmail
// ActionCodeSettings
// AuthStateChanges
// StreamBuilder auth state
// App navigation after login (MainScreen fix)