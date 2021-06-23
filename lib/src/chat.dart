import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bubble/bubble.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chatter/src/chatInput.dart';
// import 'package:bubble/issue_clipper.dart';

class ChatMessage {
  ChatMessage(
      {required this.name, required this.message, required this.userId});
  final String name;
  final String message;
  final String userId;
}

class Chat extends StatefulWidget {
  const Chat({required this.messages, required this.addMessage});
  final List<ChatMessage> messages;
  final Future<DocumentReference> Function(String message) addMessage;

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final ScrollController _scrollController = ScrollController();

  void scrollToBottom() {
    _scrollController.animateTo(0,
        duration: Duration(milliseconds: 500), curve: Curves.fastOutSlowIn);
  }

  @override
  Widget build(BuildContext context) {
    this.scrollToBottom();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
        Widget>[
      Expanded(
        child: Container(
          child: ListView.builder(
            reverse: true,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 5),
            controller: _scrollController,
            itemCount: widget.messages.length,
            itemBuilder: (BuildContext context, int index) {
              var message = widget.messages[index];
              if (message.userId == FirebaseAuth.instance.currentUser!.uid) {
                return Bubble(
                  elevation: 0,
                  alignment: Alignment.centerRight,
                  margin: BubbleEdges.only(bottom: 10),
                  color: Colors.blue,
                  nip: BubbleNip.rightTop,
                  child: Text('${message.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.0, color: Colors.white)),
                );
              } else {
                return Bubble(
                  elevation: 0,
                  alignment: Alignment.centerLeft,
                  margin: BubbleEdges.only(bottom: 10),
                  color: Colors.grey,
                  nip: BubbleNip.leftTop,
                  child: Text('${message.name}: ${message.message}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0, color: Colors.white)),
                );
              }
            },
          ),
        ),
      ),
      ChatInput(
          addMessage: (message) =>
              widget.addMessage(message).then((_) => scrollToBottom(),
                  onError: (e) => {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(e.message),
                          action: SnackBarAction(
                            label: 'Close',
                            onPressed: () {
                              // Some code to undo the change.
                            },
                          ),
                        ))
                      })),
    ]);
  }
}
