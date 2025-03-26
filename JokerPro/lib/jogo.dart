import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Para efeitos táteis

class Jogo extends StatefulWidget {
  const Jogo({Key? key}) : super(key: key);

  @override
  State<Jogo> createState() => _JogoState();
}

class _JogoState extends State<Jogo> {
  int userScore = 0;
  int appScore = 0;
  String appChoiceImage = 'images/padrao.png';
  String resultMessage = "";

  void playGame(String userChoice) {
    int appChoice = Random().nextInt(3); // 0 = pedra, 1 = papel, 2 = tesoura
    String newAppChoiceImage;
    switch (appChoice) {
      case 0:
        newAppChoiceImage = 'images/pedra.png';
        break;
      case 1:
        newAppChoiceImage = 'images/papel.png';
        break;
      case 2:
        newAppChoiceImage = 'images/tesoura.png';
        break;
      default:
        newAppChoiceImage = 'images/padrao.png';
    }
    void resetGame() {
      setState(() {
        userScore = 0;
        appScore = 0;
        appChoiceImage = 'images/padrao.png';
        resultMessage = "";
      });
    }

    String result;
    if ((userChoice == 'pedra' && appChoice == 2) ||
        (userChoice == 'papel' && appChoice == 0) ||
        (userChoice == 'tesoura' && appChoice == 1)) {
      userScore++;
      result = "Você ganhou!";
    } else if (appChoice == 0 && userChoice == 'tesoura' ||
        appChoice == 1 && userChoice == 'pedra' ||
        appChoice == 2 && userChoice == 'papel') {
      appScore++;
      result = "Você perdeu!";
    } else {
      result = "Empate!";
    }

    setState(() {
      appChoiceImage = newAppChoiceImage;
      resultMessage = result;
      HapticFeedback.lightImpact(); // Efeito tátil leve
    });
  }

  Color getScoreColor() {
    if (userScore > appScore) {
      return Colors.blue;
    } else if (userScore < appScore) {
      return Colors.red;
    } else {
      return Colors.yellow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        title: const Text('JokenPO'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: const Text(
              "Escolha do App",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Image(image: AssetImage(appChoiceImage)),
          Padding(
            padding: const EdgeInsets.only(top: 32, bottom: 16),
            child: const Text(
              "Escolha uma opção abaixo:",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => playGame('papel'),
                    child: Image(
                      image: AssetImage('images/papel.png'),
                      height: 100,
                    ),
                  ),
                  const Text('Papel')
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => playGame('pedra'),
                    child: Image(
                      image: AssetImage('images/pedra.png'),
                      height: 100,
                    ),
                  ),
                  const Text('Pedra')
                ],
              ),
              Column(
                children: <Widget>[
                  GestureDetector(
                    onTap: () => playGame('tesoura'),
                    child: Image(
                      image: AssetImage('images/tesoura.png'),
                      height: 100,
                    ),
                  ),
                  const Text('Tesoura')
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              resultMessage,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Placar: Usuário $userScore x $appScore App',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: getScoreColor(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
