import 'dart:math';

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// for variables
class MyAppState extends ChangeNotifier {
  var current = WordPair(' ', ' ');
  
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var current2 = WordPair('first', 'second');
}

// main place to code
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: Column(
        children: [
          Text('A random AWESOME idea:'),
          Text(appState.current.asLowerCase),
          //Text(appState.current2.asLowerCase),

          ElevatedButton(
            onPressed: () {
              appState.getNext();},
            child: Text ('Next'),
          )
        ],    
      ),
    );
  }
}