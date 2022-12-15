// ignore_for_file: file_names

class Chat {
  final String name, lastMessage, image;
  final DateTime time;
  final bool isActive;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.image,
    required this.time,
    required this.isActive,
  });
}

List<Chat> chatsData = [
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user_1.png",
    time: DateTime.now().subtract(Duration(minutes: 3)),
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: DateTime.now().subtract(Duration(minutes: 8)),
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: DateTime.now().subtract(Duration(days: 5)),
    isActive: false,
  ),
  Chat(
    name: "Jacob Jones",
    lastMessage: "You’re welcome :)",
    image: "assets/images/user_4.png",
    time: DateTime.now().subtract(Duration(days: 1)),
    isActive: true,
  ),
  Chat(
    name: "Albert Flores",
    lastMessage: "Thanks",
    image: "assets/images/user_5.png",
    time: DateTime.now().subtract(Duration(days: 2)),
    isActive: false,
  ),
  Chat(
    name: "Jenny Wilson",
    lastMessage: "Hope you are doing well...",
    image: "assets/images/user_1.png",
    time: DateTime.now().subtract(Duration(days: 3)),
    isActive: false,
  ),
  Chat(
    name: "Esther Howard",
    lastMessage: "Hello Abdullah! I am...",
    image: "assets/images/user_2.png",
    time: DateTime.now().subtract(Duration(days: 4)),
    isActive: true,
  ),
  Chat(
    name: "Ralph Edwards",
    lastMessage: "Do you have update...",
    image: "assets/images/user_3.png",
    time: DateTime.now().subtract(Duration(days: 5)),
    isActive: false,
  ),
];
