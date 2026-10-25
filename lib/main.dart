import 'package:chat_app/screen/chat_screen.dart';
import 'package:chat_app/screen/regisration_screen.dart';
import 'package:chat_app/screen/signin_screen.dart';
import 'package:chat_app/screen/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: _auth.currentUser != null
          ? ChatScreen.ScreenRoute
          : WelcomeScreen.ScreenRoute,
      routes: {
        WelcomeScreen.ScreenRoute: (context) => WelcomeScreen(),
        SignInScreen.screenRoute: (context) => SignInScreen(),
        RegisrationScreen.screenRoute: (context) => RegisrationScreen(),
        ChatScreen.ScreenRoute: (context) => ChatScreen(),
      },
    );
  }
}
