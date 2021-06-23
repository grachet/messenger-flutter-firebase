import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:bubble/issue_clipper.dart';

class ChatMessage {
  ChatMessage(
      {required this.name, required this.message, required this.userId});
  final String name;
  final String message;
  final String userId;
}

class Chat extends StatefulWidget {
  const Chat({required this.messages});
  final List<ChatMessage> messages;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      for (var message in widget.messages)
        message.userId == FirebaseAuth.instance.currentUser!.uid
            ? Bubble(
                elevation: 0,
                alignment: Alignment.centerRight,
                margin: BubbleEdges.only(top: 10, right: 10, left: 10),
                color: Colors.blue,
                nip: BubbleNip.rightTop,
                child: Text('${message.message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14.0, color: Colors.white)),
              )
            : Bubble(
                elevation: 0,
                alignment: Alignment.centerLeft,
                margin: BubbleEdges.only(top: 10, right: 10, left: 10),
                color: Colors.grey,
                nip: BubbleNip.leftTop,
                child: Text('${message.name}: ${message.message}',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: Colors.white)),
              ),
    ]);
  }
}
