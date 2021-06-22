import 'package:flutter/material.dart';
import 'package:second_hand/provider/applicationState.dart';

// import 'package:firebase_core/firebase_core.dart'; // new
// import 'package:firebase_auth/firebase_auth.dart'; // new
// import 'package:provider/provider.dart'; // new

// import 'src/authentication.dart'; // new
// import '../src/widgets.dart';
import '../src/signUp.dart';
import '../src/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _login() {
    print(mailController.text);
    print(passwordController.text);
    Navigator.of(context).push(_createRoute(Home()));

    ApplicationState().startLoginFlow();
    // ApplicationState().signInWithEmailAndPassword();
    // _showErrorDialog(context, 'Invalid email', e)
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
            padding: EdgeInsets.all(10),
            child: Text(
              'Connexion',
              style: TextStyle(fontSize: 20),
            )),
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
        Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          alignment: Alignment.center,
          child: Text(
            'No account ? Try guest/guest',
            style: TextStyle(color: Colors.blue),
          ),
        ),
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
