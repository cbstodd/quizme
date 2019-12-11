import 'package:flutter/material.dart';
import 'package:quizme/quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  void showAlertModal() {
    Alert(
      context: context,
      type: AlertType.info,
      title: "Congratulations!!!",
      desc: "Quiz is completed!",
      buttons: [
        DialogButton(
          child: Text(
            "Start Over",
            style: TextStyle(
              color: Colors.white70,
              fontSize: 20,
            ),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
          color: Colors.blueAccent,
        )
      ],
    ).show();
  }

  void startOver() {
    setState(() {
      showAlertModal();
      quizBrain.resetQuizIndex();
      scoreKeeper = [];
    });
  }

  void checkAnswer(bool checkedAnswerVal) {
    bool correctAnswer = quizBrain.getQuestionAnswer();
    if (correctAnswer == checkedAnswerVal && quizBrain.hasRemainingQuestions()) {
      // Correct Answer actions:
      setState(() {
        scoreKeeper.add(
          Icon(Icons.check, color: Colors.lightGreen),
        );
        quizBrain.updateQuestionNumber();
      });
    } else if (correctAnswer != checkedAnswerVal && quizBrain.hasRemainingQuestions()) {
      // Incorrect answer actions:
      setState(() {
        scoreKeeper.add(
          Icon(Icons.close, color: Colors.redAccent),
        );
        quizBrain.updateQuestionNumber();
      });
      // Show alert modal and reset quiz index:
    } else {
      startOver();
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
                quizBrain.getQuestionText(),
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
              color: Colors.blueAccent,
              child: Text(
                'Go Back',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  quizBrain.goBack();
                  scoreKeeper.removeLast();
                });
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
                'Start Over',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                startOver();
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
