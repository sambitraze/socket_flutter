import 'package:flutter/material.dart';
import 'package:socket_flutter/objectbox.dart';
import 'package:socket_flutter/splash_screen.dart';
import 'package:socket_flutter/utils/theme.dart';
late ObjectBox objectbox;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create();
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
