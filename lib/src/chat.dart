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
  final _formKey = GlobalKey<FormState>(debugLabel: '_ChatState');
  final _controller = TextEditingController();

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
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onFieldSubmitted: (text) async {
                      if (_formKey.currentState!.validate()) {
                        await widget.addMessage(_controller.text);
                        _controller.clear();
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      // prefixIcon: Icon(Icons.mail),
                      // border: OutlineInputBorder(),
                      // labelText: 'Mail',
                    ),
                    controller: _controller,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your message to continue';
                      }
                      return null;
                    },
                  ),
                ),
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
                    if (_formKey.currentState!.validate()) {
                      await widget.addMessage(_controller.text);
                      _controller.clear();
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
