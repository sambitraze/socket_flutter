import 'package:flutter/material.dart';
import 'package:socket_flutter/utils/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    //show profile picture and otehr profiel details editable and logout button
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            const CircleAvatar(
              radius: 48,
              backgroundImage: AssetImage('assets/images/user_2.png'),
            ),
            const SizedBox(
              height: kDefaultPadding * 2,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : kPrimaryColor,
              title: const Text(
                "First Name",
              ),
              subtitle: Text(
                "John",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Icon(
                Icons.edit,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding / 4,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : kPrimaryColor,
              title: const Text(
                "Last Name",
              ),
              subtitle: Text(
                "Doe",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Icon(
                Icons.edit,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding / 4,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : kPrimaryColor,
              title: const Text(
                "Email",
              ),
              subtitle: Text(
                "jhon.doe@gmail.com",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding / 4,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : kPrimaryColor,
              title: const Text(
                "Phone",
              ),
              subtitle: Text(
                "+91 1234567890",
                style: Theme.of(context).textTheme.bodyText1,
              ),
              trailing: Icon(
                Icons.edit,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const SizedBox(
              height: kDefaultPadding / 4,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              tileColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.black
                  : kPrimaryColor,
              title: const Text(
                "logout",
              ),
              subtitle: Text(
                "we will miss you",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .color!
                        .withOpacity(0.5)),
              ),
              trailing: Icon(
                Icons.exit_to_app,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            const Spacer(),
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
          ],
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: const Text("Settings"),
    );
  }
}
