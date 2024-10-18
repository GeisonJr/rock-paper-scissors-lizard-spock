import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    ));

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  final List<String> _choices = [
    'Rock',
    'Paper',
    'Scissors',
    'Lizard',
    'Spock'
  ];
  String _winner = '';
  String _choiceComputer = '';
  String _choiceUser = '';
  String _lastChoiceComputer = '';
  String _lastChoiceUser = '';
  int _winsComputer = 0;
  int _winsUser = 0;
  int _winsTie = 0;

  @override
  void initState() {
    super.initState();
  }

  void resetFields() {
    setState(() {
      _winner = '';
      _choiceComputer = '';
      _choiceUser = '';
      _lastChoiceComputer = '';
      _lastChoiceUser = '';
      _winsComputer = 0;
      _winsUser = 0;
      _winsTie = 0;
    });
  }

  void getWinner(String choiceUser) {
    if (_lastChoiceUser == 'Rock' && choiceUser == 'Rock') {
      setState(() {
        _winner = 'You can\'t choose Rock twice in a row';
      });
      return;
    }

    String choiceComputer = _choices[Random().nextInt(_choices.length)];

    while (_lastChoiceComputer == 'Rock' && choiceComputer == 'Rock') {
      choiceComputer = _choices[Random().nextInt(_choices.length)];
    }

    String winner = 'Computer';

    if (choiceUser == choiceComputer) {
      winner = 'Tie';
    } else if (choiceUser == 'Rock' && choiceComputer == 'Scissors') {
      winner = 'You';
    } else if (choiceUser == 'Rock' && choiceComputer == 'Lizard') {
      winner = 'You';
    } else if (choiceUser == 'Paper' && choiceComputer == 'Rock') {
      winner = 'You';
    } else if (choiceUser == 'Paper' && choiceComputer == 'Spock') {
      winner = 'You';
    } else if (choiceUser == 'Scissors' && choiceComputer == 'Paper') {
      winner = 'You';
    } else if (choiceUser == 'Scissors' && choiceComputer == 'Lizard') {
      winner = 'You';
    } else if (choiceUser == 'Lizard' && choiceComputer == 'Paper') {
      winner = 'You';
    } else if (choiceUser == 'Lizard' && choiceComputer == 'Spock') {
      winner = 'You';
    } else if (choiceUser == 'Spock' && choiceComputer == 'Rock') {
      winner = 'You';
    } else if (choiceUser == 'Spock' && choiceComputer == 'Scissors') {
      winner = 'You';
    }

    setState(() {
      _choiceComputer = choiceComputer;
      _choiceUser = choiceUser;
      _lastChoiceComputer = choiceComputer;
      _lastChoiceUser = choiceUser;
      _winsComputer = winner == 'Computer' ? _winsComputer + 1 : _winsComputer;
      _winsUser = winner == 'You' ? _winsUser + 1 : _winsUser;
      _winsTie = winner == 'Tie' ? _winsTie + 1 : _winsTie;
      _winner = winner != 'Tie' ? '$winner wins!' : 'Tie';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rock Paper Scissors Lizard Spock'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              resetFields();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildUserInfo('You', _winsUser, _choiceUser),
                Column(
                  children: [
                    const Text('VS'),
                    Text(
                      'Ties: $_winsTie',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                buildUserInfo('Computer', _winsComputer, _choiceComputer),
              ],
            ),
            Text(
              _winner,
              style: const TextStyle(fontSize: 30),
            ),
            Column(
              children: [
                const Text(
                  'Choose your weapon',
                  style: TextStyle(fontSize: 20),
                ),
                Wrap(
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  runSpacing: 50,
                  children: [
                    for (var choice in _choices) buildAvaliableWeapons(choice),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildUserInfo(String user, int wins, String choice) {
    return Column(
      children: [
        Text(
          user,
          style: const TextStyle(fontSize: 20),
        ),
        Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: AssetImage(
                choice.isEmpty
                    ? 'images/default.jpg'
                    : 'images/${choice.toLowerCase()}.jpg',
              ),
            ),
            Text(
              choice,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        Text(
          'Wins: $wins',
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  Column buildAvaliableWeapons(String option) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => {getWinner(option)},
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('images/${option.toLowerCase()}.jpg'),
          ),
        ),
        Text(
          option,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
