import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'provider/applicationState.dart';
// import 'src/home.dart';
import 'src/login.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ApplicationState(),
      builder: (context, _) => App(),
    ),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatter',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
              backgroundColor: Colors.white,
            ),
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor: Colors.blue,
            ),
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Login(),
    );
  }
}
