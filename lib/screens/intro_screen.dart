import 'package:flutter/material.dart';
import 'package:socket_flutter/screens/sign_in_screen.dart';
import 'package:socket_flutter/utils/constants.dart';

class IntroScreen1 extends StatelessWidget {
  const IntroScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(
              flex: 2,
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Image.asset('assets/images/logo.png'),
            ),
            const Spacer(
              flex: 3,
            ),
            Text(
              "Welcome to EZ Chat",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Text(
                "The easiest way to chat with your friends and family in real time",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.5)),
              ),
            ),
            const Spacer(
              flex: 2,
            ),
            FittedBox(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "Next",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .color!
                                .withOpacity(0.8),
                          ),
                    ),
                    const SizedBox(width: kDefaultPadding / 4),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .color!
                          .withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Made with ❤️ by Sambit",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.8),
                  ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
