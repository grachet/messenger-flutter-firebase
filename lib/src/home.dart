import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/profil.dart';
import '../provider/applicationState.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../src/chat.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.all(5), child: Image.asset('assets/logo.png')),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Public chat',
            style: TextStyle(color: Colors.black),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Text(
              appState.email ?? "Me",
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          Text(
            FirebaseAuth.instance.currentUser!.displayName ?? "Me",
            style: TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ]),
        // title: Container(
        //     height: 40,
        //     child: const TextField(
        //       decoration: InputDecoration(
        //           prefixIcon: Icon(Icons.search),
        //           border: OutlineInputBorder(),
        //           hintText: 'Search',
        //           isDense: true,
        //           contentPadding: EdgeInsets.all(8)),
        //     )),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 40,
              ),
              onPressed: () =>
                  {Navigator.of(context).push(_createRoute(Profil()))},
            ),
          ),
        ],
      ),
      body: Consumer<ApplicationState>(
        builder: (context, appState, _) => Chat(
          messages: appState.chatMessages,
          addMessage: appState.addMessageToChat,
        ),
      ),
    );
  }
}

Route _createRoute(Widget widget) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return child;
    },
  );
}
