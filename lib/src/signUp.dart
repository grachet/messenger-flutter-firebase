import 'package:flutter/material.dart';
import 'package:chatter/src/applicationState.dart';
import 'package:chatter/src/home.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String _error = "";

  TextEditingController mailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    ApplicationState().signInWithEmailAndPassword(
        mailController.text,
        passwordController.text,
        () => Navigator.of(context).push(_createRoute(Home())),
        (e) => {
              setState(() {
                _error = e.message.toString();
              })
            });
  }

  void _signUp() {
    setState(() {
      _error = "";
    });
    ApplicationState().startLoginFlow();
    ApplicationState().registerAccount(
        mailController.text,
        nameController.text,
        passwordController.text,
        () => _login(),
        (e) => {
              setState(() {
                _error = e.message.toString();
              })
            });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: ListView(
      padding: const EdgeInsets.all(20.0),
      shrinkWrap: true,
      children: <Widget>[
        Container(
            alignment: Alignment.center,
            width: 150,
            height: 150,
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.account_circle,
              color: Colors.blue,
              size: 150,
            )),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            child: Text(
              'Create account',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 30),
            )),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: mailController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Mail',
              prefixIcon: Icon(Icons.mail),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Pseudo',
              prefixIcon: Icon(Icons.account_circle),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          // alignment: Alignment.center,
          child: Text(
            _error,
            style: TextStyle(color: Colors.red),
          ),
        ),
        Container(
            height: 60,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: ElevatedButton(
              child: Text(
                'Sign Up',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _signUp();
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              children: <Widget>[
                Text('Already have an account? '),
                TextButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ))
      ],
    )));
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
