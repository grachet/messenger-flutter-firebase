import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:second_hand/src/authentication.dart';

import '../src/widgets.dart';
import '../provider/applicationState.dart';

class Profil extends StatelessWidget {
  const Profil({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          tooltip: 'Increase volume by 10',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'My items',
            style: TextStyle(color: Colors.black),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Text(
              appState.email ?? "Mail",
              style: TextStyle(fontSize: 15, color: Colors.black38),
            ),
          ),
        ]),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: StyledButton(
                onPressed: () {
                  ApplicationState().signOut();
                  Navigator.popUntil(
                      context, (Route<dynamic> predicate) => predicate.isFirst);
                },
                child: const Text('Logout'),
              ),
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
                // Add from here

                const Paragraph('Todo list items of user'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
