import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
// import 'package:bubble/issue_clipper.dart';

class ChatMessage {
  ChatMessage({required this.name, required this.message});
  final String name;
  final String message;
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
        message.name == "Guest2"
            ? Bubble(
                elevation: 0,
                alignment: Alignment.centerRight,
                margin: BubbleEdges.only(top: 10, right: 10, left: 10),
                color: Colors.blue,
                nip: BubbleNip.rightTop,
                child: Text('${message.name}: ${message.message}',
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

class ChatInput extends StatefulWidget {
  const ChatInput({required this.addMessage});
  final FutureOr<void> Function(String message) addMessage;

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _messageController = TextEditingController();

  TextEditingController messageController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        child: Row(
          children: [
            Expanded(
                child: Container(
              height: 45,
              child: TextField(
                onSubmitted: (text) async {
                  if (_messageController.text != "") {
                    await widget.addMessage(_messageController.text);
                    _messageController.clear();
                  }
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.message),
                  isDense: true,
                  contentPadding: EdgeInsets.all(8),
                ),
                controller: _messageController,
              ),
            )),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(
                Icons.thumb_up,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () async {
                await widget.addMessage("👍");
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.blue,
                size: 30,
              ),
              onPressed: () async {
                if (_messageController.text != "") {
                  await widget.addMessage(_messageController.text);
                  _messageController.clear();
                }
              },
            ),
          ],
        ),
      ),
      // ),
      // ],
    );
  }
}
