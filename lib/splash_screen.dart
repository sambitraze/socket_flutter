import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:socket_flutter/screens/intro_screen.dart';
import 'package:socket_flutter/screens/landing_screen.dart';
import 'package:socket_flutter/services/auth_service.dart';
import 'package:socket_flutter/services/base_service.dart';

class SplashScrren extends StatefulWidget {
  const SplashScrren({super.key});

  @override
  State<SplashScrren> createState() => _SplashScrrenState();
}

class _SplashScrrenState extends State<SplashScrren> {
  String state = "connecting";
  @override
  void initState() {
    super.initState();
    startTime(context);
  }

  startTime(context) async {
    var duration = const Duration(milliseconds: 2500);
    var duration2 = const Duration(milliseconds: 3500);
    var duration3 = const Duration(milliseconds: 3500);
    // BaseService.makeUnauthenticatedRequest()
    Timer(duration, (){
      setState(() {
        state = "error";
      });
    });
    Timer(duration2, (){
      setState(() {
        state = "success";
      });
    });
    return Timer(duration3, () async {
      var auth = await AuthService.getSavedAuth();
      if (auth.isNotEmpty) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const LandingScreen()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> const IntroScreen1()));
      }
    });
  }
  Widget gifSwitcher () {
    switch (state) {
      case "connecting":
        return Image.asset("assets/animations/loading.gif");
      case "error":
        return Image.asset("assets/animations/failure.gif");
      case "success":
        return Image.asset("assets/animations/success.gif");
      default:
        return Image.asset("assets/animations/loading.gif");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gifSwitcher(),
            Text(
              "Checking for server",
              style: GoogleFonts.nunito(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
