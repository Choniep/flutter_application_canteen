import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_canteen/services/auth/auth_gate.dart';
import 'package:flutter_application_canteen/services/auth/login_or_register.dart';
import 'package:flutter_application_canteen/firebase_options.dart';
import 'package:flutter_application_canteen/models/restaurant.dart';
import 'package:flutter_application_canteen/pages/register_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_canteen/pages/login_page.dart';
import 'package:flutter_application_canteen/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        // theme provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),

        // restaurant provider
        ChangeNotifierProvider(create: (contex) => Restaurant())
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
