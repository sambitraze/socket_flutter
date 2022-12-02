import 'package:flutter/material.dart';
import 'package:socket_flutter/screens/intro_screen.dart';
import 'package:socket_flutter/splash_screen.dart';
import 'package:socket_flutter/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EZ Chat',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      themeMode: ThemeMode.dark,
      home: const SplashScrren(),
    );
  }
}
