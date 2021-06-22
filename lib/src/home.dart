import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src/profil.dart';
import '../provider/applicationState.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: EdgeInsets.all(5), child: Image.asset('assets/logo.png')),
        title: Container(
            height: 40,
            child: const TextField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  hintText: 'Search',
                  isDense: true,
                  contentPadding: EdgeInsets.all(8)),
            )),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: IconButton(
              icon: const Icon(
                Icons.account_circle,
                color: Colors.blue,
                size: 40,
              ),
              tooltip: 'Increase volume by 10',
              onPressed: () =>
                  {Navigator.of(context).push(_createRoute(Profil()))},
            ),
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GuestBook(
                  addMessage: (message) =>
                      appState.addMessageToGuestBook(message),
                  messages: appState.guestBookMessages,
                ),
              ],
            ),
          ),
        ],
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
