import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // IO.Socket socketIO;
  // List<String> messages;
  // double height, width;
  // TextEditingController textController;
  // ScrollController scrollController;
  IO.Socket socket = IO.io('http://192.168.1.102:8080', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });

  @override
  void initState() {
    super.initState();
    socket.connect();
    socket.onConnect((c) {
      print("connected");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          socket.disconnect();
          // IO.Socket socket =
          //     IO.io('http://192.168.1.102:8080', <String, dynamic>{
          //   'transports': ['websocket'],
          //   'autoConnect': false,
          // });
          // socket.connect();
          // socket.onConnect((c) {
          //   print("connected");
          // });
          // socket.onDisconnect((_) => print('disconnect'));
        },
      ),
    );
  }
}
