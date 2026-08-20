import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Controllerr/auth_controller.dart';
import 'Screens/home_Screen.dart';
import 'Screens/login_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,

      title: "My Login App",

      initialRoute: '/login',

      getPages: [
        GetPage(
          name: '/login',
          page: () => LoginScreen(),
        ),

        GetPage(
          name: '/home',
          page: () => HomeScreen(),
        ),
      ],
    );
  }
}