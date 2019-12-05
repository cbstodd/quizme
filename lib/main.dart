import 'package:flutter/material.dart';
import 'package:quizme/quiz_brain.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizme());

class Quizme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade800,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];
  int questionIndex = 0;

  void updateQuestionNumber() {
    if (questionIndex < quizBrain.getQuestionBankLength()) {
      questionIndex += 1;
    } else {
      quizBrain.setNewQuestion(0, "All Questions answered!", true);
      print("Index: 0, Text: All Questions answered!, BoolAnswer: true");
      questionIndex = 0;
    }
  }

  void checkAnswer(bool checkedAnswerVal) {
    bool correctAnswer = quizBrain.getQuestionAnswer(questionIndex);
    if (correctAnswer == checkedAnswerVal) {
      // Correct Answer actions:
      setState(() {
        scoreKeeper.add(
          Icon(Icons.check, color: Colors.lightGreen),
        );
        updateQuestionNumber();
      });
    } else {
      // Incorrect answer actions:
      setState(() {
        scoreKeeper.add(
          Icon(Icons.close, color: Colors.redAccent),
        );
        updateQuestionNumber();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(questionIndex),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.grey.shade400,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.lightGreen,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                checkAnswer(true);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                checkAnswer(false);
              },
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.orangeAccent,
              child: Text(
                'Clear',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState(() {
                  scoreKeeper.clear();
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
