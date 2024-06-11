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
          //for color theme
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

// for variables and functions
class MyAppState extends ChangeNotifier {
  var current = WordPair(' ', ' ');
  
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favorites = <WordPair>[]; // list
  var favorites2= <WordPair>{}; // set

  void toggleFavourites(){
    if (favorites.contains(current)){
      favorites.remove(current);
    }else {
      favorites.add(current);
    }
    notifyListeners();
  }

  var current2 = WordPair('first', 'second');
}

// main place to code / UI
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)){
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            //Text(appState.current.asLowerCase),
            //Text(appState.current2.asLowerCase),

            SizedBox(height: 20,),

            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: (){
                    appState.toggleFavourites();}, 
                icon: Icon(icon),
                label: Text ('Like'),
                ),
                ElevatedButton(
                  onPressed: () {
                    appState.getNext();},
                  child: Text ('Next'),
                ),
              ],
            ),
          ],    
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //for color
    final style = theme.textTheme.displayMedium!.copyWith(color: theme.colorScheme.onPrimary, backgroundColor: theme.colorScheme.secondary);

    return Card(
      color: theme.colorScheme.primary,
      //color: theme.colorScheme.fromSeed(seedColor: Colors.green),
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Text(pair.asLowerCase, style: style, semanticsLabel: "${pair.first} ${pair.second}",),
      ),
    );
  }
}