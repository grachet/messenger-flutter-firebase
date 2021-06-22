import 'package:flutter/material.dart';
import 'package:second_hand/provider/applicationState.dart';
import '../src/signUp.dart';
import '../src/home.dart';

class Login extends StatefulWidget {
  Login() {
    ApplicationState().init();
    ApplicationState().startLoginFlow();
  }

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _error = "";

  TextEditingController mailController =
      TextEditingController(text: "guest@gmail.com");
  TextEditingController passwordController =
      TextEditingController(text: "password");

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
            child: Image.asset('assets/logo.png')),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Text(
              'SECOND HAND',
              style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.w500,
                  fontSize: 30),
            )),
        Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
            child: Text(
              'Connexion',
              style: TextStyle(fontSize: 20),
            )),
        Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          // alignment: Alignment.center,
          child: Text(
            _error,
            style: TextStyle(color: Colors.red),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: TextField(
            controller: mailController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.mail),
              border: OutlineInputBorder(),
              labelText: 'Mail',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: TextField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.lock),
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
          ),
        ),
        // Container(
        //   padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        //   alignment: Alignment.center,
        //   child: Text(
        //     'No account ? Try guest@gmail.com/password',
        //     style: TextStyle(color: Colors.blue),
        //   ),
        // ),
        Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: ElevatedButton(
              child: Text(
                'Sign In',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                _login();
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              children: <Widget>[
                Text('Does not have account? '),
                TextButton(
                  child: Text(
                    'Create',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(_createRoute(SignUp()));
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
