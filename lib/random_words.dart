import 'package:flutter/material.dart';
import 'dart:math'; // Import the math library for random number generation
import 'MyWords.dart'; // Import your custom word list

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final List<String> _randomWordPairs = [];
  final Set<String> _savedWordPairs = Set<String>();
  final int _numberOfPairs = 10; // Desired number of random pairs

  // Function to generate random car word pairs from the MyWords list
  void _generateRandomPairs() {
    final random = Random();
    _randomWordPairs.clear(); // Clear existing pairs to regenerate

    // Generate random combinations of car words
    while (_randomWordPairs.length < min(_numberOfPairs, MyWords.length)) {
      final firstWord = MyWords[random.nextInt(MyWords.length)];
      final secondWord = MyWords[random.nextInt(MyWords.length)];
      final combinedWordPair = '$firstWord & $secondWord'; // Combine words

      // Avoid duplicates
      if (!_randomWordPairs.contains(combinedWordPair)) {
        _randomWordPairs.add(combinedWordPair);
      }
    }
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, item) {
        if (item.isOdd) return Divider();
        final index = item ~/ 2;
        if (index >= _randomWordPairs.length) {
          _generateRandomPairs(); // Generate pairs if needed
        }
        return _buildRow(_randomWordPairs[index]);
      },
    );
  }

  Widget _buildRow(String pair) {
    final alreadySaved = _savedWordPairs.contains(pair);

    return ListTile(
      title: Text(
        pair,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      trailing: Icon(
        alreadySaved ? Icons.star : Icons.star_border,
        color: alreadySaved ? const Color.fromARGB(255, 243, 239, 22) : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedWordPairs.remove(pair);
          } else {
            _savedWordPairs.add(pair);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context) {
        final Iterable<ListTile> tiles = _savedWordPairs.map((String pair) {
          return ListTile(
            title: Text(
              pair,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
          );
        });

        final List<Widget> divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();
        return Scaffold(
          appBar: AppBar(title: const Text('Saved Car Models')),
          body: ListView(children: divided),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Cars Generator'),
        actions: <Widget>[
          IconButton(onPressed: _pushSaved, icon: Icon(Icons.list)),
        ],
      ),
      body: _buildList(),
    );
  }
}