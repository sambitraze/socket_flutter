import 'package:flutter/material.dart';
import 'package:socket_flutter/screens/home_screen.dart';
import 'package:socket_flutter/screens/sign_up_screen.dart';
import '../utils/constants.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 120.0),
              child: Image.asset('assets/images/logo.png'),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  filled: true,
                  hintStyle: Theme.of(context).textTheme.bodyText1!,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  fillColor: Colors.white60,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide:
                        const BorderSide(color: kContentColorLightTheme),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide:
                        const BorderSide(color: kContentColorLightTheme),
                    gapPadding: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: TextFormField(
                obscureText: !showPassword,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    padding: const EdgeInsets.only(right: kDefaultPadding),
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).textTheme.bodyText1!.color,
                    ),
                  ),
                  hintText: "Password",
                  filled: true,
                  hintStyle: Theme.of(context).textTheme.bodyText1!,
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  fillColor: Colors.white60,
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide:
                        const BorderSide(color: kContentColorLightTheme),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide:
                        const BorderSide(color: kContentColorLightTheme),
                    gapPadding: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: kDefaultPadding,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Not a member? Sign Up",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.6),
                        ),
                  ),
                ),
                Text(
                  " | ",
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                      ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignUpScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.bodyText1!.copyWith(
                          color: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .color!
                              .withOpacity(0.6),
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
              child: GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                ),
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    gradient: LinearGradient(
                      colors: [kPrimaryColor, kSecondaryColor],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.button!.copyWith(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
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
