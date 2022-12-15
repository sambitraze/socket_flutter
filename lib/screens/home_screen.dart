import 'package:flutter/material.dart';
import 'package:socket_flutter/components/chat_card.dart';
import 'package:socket_flutter/components/filled_outline_button.dart';
import 'package:socket_flutter/models/Chat.dart';
import 'package:socket_flutter/screens/chat_screen.dart';
import 'package:socket_flutter/services/auth_service.dart';
import 'package:socket_flutter/services/base_service.dart';
import 'package:socket_flutter/services/user_service.dart';
import 'package:socket_flutter/utils/constants.dart';
import 'package:socket_flutter/utils/show_toast.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  final Map user;
  const HomeScreen({super.key, required this.user});

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
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          http.Response response = await AuthService.makeAuthenticatedRequest(
              "${BaseService.BASE_URL}users",
              method: "GET");
          print(response.body);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
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
          child: FutureBuilder(
            future: UserService.getAllUsers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting ||
                  snapshot.connectionState == ConnectionState.none) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text("No Data Found${snapshot.error}"));
              }
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ChatCard(
                    // chat: chatsData[index],
                    chat: Chat(
                      name: snapshot.data![index].firstName,
                      lastMessage: "Hello",
                      time: DateTime.now(),
                      image: snapshot.data![index].photoUrl,
                      isActive: true,
                    ),
                    press: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            // isGroup: index.isEven,
                            isGroup: false,
                            chat: Chat(
                              name: snapshot.data![index].firstName,
                              lastMessage: "Hello",
                              time: DateTime.now(),
                              image: snapshot.data![index].photoUrl,
                              isActive: true,
                            ),
                            chatUser: snapshot.data![index],
                            currentUser: widget.user,
                          ),
                        ),
                      );
                    },
                  );
                },
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
          const Text('Chats'),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            showToast(context, "Coming Soon", "info");
          },
        ),
      ],
    );
  }
}
