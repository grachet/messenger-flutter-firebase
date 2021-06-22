import 'package:flutter/material.dart';

enum ApplicationLoginState {
  loggedOut,
  emailAddress,
  register,
  password,
  loggedIn,
}

class AppBarSearch extends StatelessWidget {
  final ApplicationLoginState loginState;
  final String? email;
  final void Function() startLoginFlow;
  final void Function(
    String email,
    void Function(Exception e) error,
  ) verifyEmail;
  final void Function(
    String email,
    String password,
    void Function(Exception e) error,
  ) signInWithEmailAndPassword;
  final void Function() cancelRegistration;
  final void Function(
    String email,
    String displayName,
    String password,
    void Function(Exception e) error,
  ) registerAccount;
  final void Function() signOut;

  const AppBarSearch({
    required this.loginState,
    required this.email,
    required this.startLoginFlow,
    required this.verifyEmail,
    required this.signInWithEmailAndPassword,
    required this.cancelRegistration,
    required this.registerAccount,
    required this.signOut,
  });

  @override
  Widget build(BuildContext context) => AppBar(
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
              child: Icon(
                Icons.account_circle,
                color: Colors.blue,
              )),
        ],
      );
}
