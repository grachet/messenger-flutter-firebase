import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chatter/src/widgets.dart';
import 'package:chatter/src/applicationState.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profil extends StatefulWidget {
  @override
  _ProfilState createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  TextEditingController nameController = TextEditingController(
      text: FirebaseAuth.instance.currentUser!.displayName);

  void _updateFullName() {
    ApplicationState().updateDisplayName(
        nameController.text,
        () => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('Pseudo updated'),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              ))
            },
        (e) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(e.message ?? "Error"),
                action: SnackBarAction(
                  label: 'Close',
                  onPressed: () {
                    // Some code to undo the change.
                  },
                ),
              ))
            });
  }

  final dateFormat = DateFormat('dd/MM/yyyy');

  @override
  Widget build(BuildContext context) {
    print(FirebaseAuth.instance.currentUser);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(color: Colors.black),
        ),
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
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        children: <Widget>[
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: Icon(Icons.mail),
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email ?? "",
                  style: const TextStyle(
                      fontWeight: FontWeight.w800, fontSize: 20),
                ),
              ])),
          Container(
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                "Account creation on " +
                    dateFormat.format(FirebaseAuth
                            .instance.currentUser!.metadata.creationTime ??
                        new DateTime(0)),
                style: const TextStyle(fontSize: 18),
              )),
          Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Text(
                "Last connection on " +
                    dateFormat.format(FirebaseAuth
                            .instance.currentUser!.metadata.lastSignInTime ??
                        new DateTime(0)),
                style: const TextStyle(fontSize: 18),
              )),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
                labelText: 'Pseudo',
              ),
            ),
          ),
          Container(
              height: 50,
              child: ElevatedButton(
                child: Text(
                  'Update',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _updateFullName();
                },
              )),
        ],
      ),
    );
  }
}
