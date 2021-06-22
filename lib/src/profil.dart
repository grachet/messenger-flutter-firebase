import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../src/widgets.dart';
import '../provider/applicationState.dart';
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
                content: Text('Updated'),
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
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Profile',
            style: TextStyle(color: Colors.black),
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
          Text(
            FirebaseAuth.instance.currentUser!.email ?? "",
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Account creation " +
                dateFormat.format(
                    FirebaseAuth.instance.currentUser!.metadata.creationTime ??
                        new DateTime(0)),
            style: const TextStyle(fontSize: 18),
          ),
          Text(
            "Last connection " +
                dateFormat.format(FirebaseAuth
                        .instance.currentUser!.metadata.lastSignInTime ??
                    new DateTime(0)),
            style: const TextStyle(fontSize: 18),
          ),
          Container(
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.account_circle),
                border: OutlineInputBorder(),
                labelText: 'Full Name',
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
