import 'dart:async';
import 'package:flutter/material.dart';

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
