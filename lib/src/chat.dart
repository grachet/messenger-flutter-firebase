import 'dart:async';
import 'package:flutter/material.dart';

import '../src/widgets.dart';

class ChatMessage {
  ChatMessage({required this.name, required this.message});
  final String name;
  final String message;
}

class Chat extends StatefulWidget {
  const Chat({required this.addMessage, required this.messages});
  final FutureOr<void> Function(String message) addMessage;
  final List<ChatMessage> messages;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final _messageController = TextEditingController();

  TextEditingController messageController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var message in widget.messages)
          Paragraph('${message.name}: ${message.message}'),
        const SizedBox(height: 8),
        Padding(
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
        ),
      ],
    );
  }
}
