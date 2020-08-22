import 'package:flutter/material.dart';
import 'package:quizzler/question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuestionBrain brain = QuestionBrain();

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey[900],
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Quizzler(),
          ),
        ),
      ),
    ),
  );
}

class Quizzler extends StatefulWidget {
  @override
  _QuizzlerState createState() => _QuizzlerState();
}

class _QuizzlerState extends State<Quizzler> {
  List<Icon> scoreKeeper = [];
  bool userPickedAnswer = false;

  void endOfQuizCheck() {
    if (brain.isFinished()) {
      Alert(
        context: context,
        type: AlertType.error,
        title: "FINISHED!",
        desc: "You have reached the end of the quiz.",
        buttons: [
          DialogButton(
            child: Text(
              "OK",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                brain.reset();
                scoreKeeper = [];
              });
              Navigator.pop(context);
            },
            width: 120,
          ),
        ],
      ).show();
    } else {
      checkAnswer();
    }
  }

  void checkAnswer() {
    bool correctAnswer = brain.getAnswer();

    if (userPickedAnswer == correctAnswer) {
      scoreKeeper.add(Icon(Icons.check, color: Colors.green));
    } else {
      scoreKeeper.add(Icon(Icons.close, color: Colors.red));
    }

    setState(() {
      brain.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(
              child: Text(brain.getQuestion(),
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  )),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              onPressed: () {
                //User picked TRUE

                userPickedAnswer = true;
                endOfQuizCheck();
              },
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: FlatButton(
              onPressed: () {
                //User picked FALSE
                userPickedAnswer = false;
                endOfQuizCheck();
              },
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Row(
            children: scoreKeeper,
          ),
        )
      ],
    );
  }
}
