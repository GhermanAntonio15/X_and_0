import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final String _playerOne = 'X';
  final String _playerTwo = 'O';
  final Color _playerTwoColor = Colors.redAccent;
  final Color _playerOneColor = Colors.blueAccent;

  String? _currentPlayer;
  late bool _gameEnd;
  late List<String> _positions;

  @override
  void initState() {
    startGame();
    super.initState();
  }

  void startGame() {
    _currentPlayer = _playerOne;
    _gameEnd = false;
    _positions = <String>[' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
          centerTitle: true,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemCount: 9,
                itemBuilder: (BuildContext context, int index) {
                  return _box(index);
                }),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                startGame();
              });
            },
            child: const Text('Reset'),
          )
        ]));
  }

  Widget _box(int index) {
    return GestureDetector(
      onTap: () {
        if (!_gameEnd || !_positions[index].isNotEmpty) {
          setState(() {
            _positions[index] = _currentPlayer!;
            _currentPlayer = _currentPlayer == _playerOne ? _playerTwo : _playerOne;
            checkForWinner();
            if (!_gameEnd) {
              checkForDraw();
            }
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 100,
        width: 100,
        decoration: BoxDecoration(
          color: _positions[index] == ' '
              ? Colors.black12
              : _positions[index] == _playerOne
                  ? _playerOneColor
                  : _playerTwoColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.black45),
        ),
      ),
    );
  }

  void checkForWinner() {
    final List<List<int>> winningList = <List<int>>[
      <int>[0, 1, 2],
      <int>[3, 4, 5],
      <int>[6, 7, 8],
      <int>[0, 3, 6],
      <int>[1, 4, 7],
      <int>[2, 5, 8],
      <int>[0, 4, 8],
      <int>[2, 4, 6],
    ];

    for (final List<int> winningPos in winningList) {
      final String playerPosition0 = _positions[winningPos[0]];
      final String playerPosition1 = _positions[winningPos[1]];
      final String playerPosition2 = _positions[winningPos[2]];

      if (playerPosition0.compareTo(' ') != 0 ||
          playerPosition1.compareTo(' ') != 0 ||
          playerPosition2.compareTo(' ') != 0) {
        if (playerPosition0 == playerPosition1 && playerPosition0 == playerPosition2) {
          dialogBox(context, playerPosition0);
          _gameEnd = true;
        }
      }
    }
  }

  void dialogBox(BuildContext context, String playerWin) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(title: const Text('End Game'), content: Text('$playerWin wins'), actions: <Widget>[
          TextButton(
              onPressed: () {
                setState(() {
                  startGame();
                  Navigator.of(context, rootNavigator: true).pop();
                });
              },
              child: const Text('Try again ?')),
          TextButton(
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
              child: const Text('OK'))
        ]);
      },
    );
  }

  void checkForDraw() {
    if (!_positions.contains(' ')) {
      dialogBox(context, 'Draw');
      _gameEnd = true;
    }
  }
}
