import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:socket_flutter/components/chat_card.dart';
import 'package:socket_flutter/components/filled_outline_button.dart';
import 'package:socket_flutter/models/Chat.dart';
import 'package:socket_flutter/utils/constants.dart';
import 'package:socket_flutter/utils/show_toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(
              kDefaultPadding, 0, kDefaultPadding, kDefaultPadding),
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.black
              : kPrimaryColor,
          child: Row(
            children: [
              FillOutlineButton(
                press: () {
                  setState(() {
                    tabIndex = 0;
                  });
                },
                text: "All Chats",
                isFilled: tabIndex == 0 ? true : false,
              ),
              const SizedBox(
                width: kDefaultPadding,
              ),
              FillOutlineButton(
                press: () {
                  // setState(() {
                  //   tabIndex = 1;
                  // });
                  showToast(context, "Coming Soon", "info");
                },
                text: "Favourites",
                isFilled: tabIndex == 1 ? true : false,
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: chatsData.length,
            itemBuilder: (context, index) {
              return ChatCard(
                chat: chatsData[index],
              );
            },
          ),
        )
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              'assets/images/logo.png',
              height: 24,
            ),
          ),
          const SizedBox(
            width: kDefaultPadding / 2,
          ),
          const Text('EZ Chat'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () {},
        ),
      ],
    );
  }
}
