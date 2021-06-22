import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Second Hand",
    theme: ThemeData(primarySwatch: Colors.blue),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<MyApp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
            child: Image.asset('images/logo.png')),
        Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
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
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
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
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            //forgot password screen
          },
          child: Text(
            'Forgot Password',
            style: TextStyle(color: Colors.blue),
          ),
        ),
        Container(
            height: 65,
            padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
            child: ElevatedButton(
              child: Text(
                'Login',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print(nameController.text);
                print(passwordController.text);
              },
            )),
        Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              children: <Widget>[
                Text('Does not have account? '),
                TextButton(
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, color: Colors.blue),
                  ),
                  onPressed: () {
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
