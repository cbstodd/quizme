import 'package:quizme/question.dart';

int _questionIndex = 0;

class QuizBrain {
  List<Question> _questionBank = [
    Question("Do onions cause people to laugh?", false),
    Question("Can fire blankets be used to put out fires?", true),
    Question("People can lick their elbow?", false),
    Question("Can you lie and tell the truth at the same time?", false),
    Question("Year 12 should be taken as a big joke?", false),
    Question("Green light means go", true),
    Question("Is Will Farrell in the movie Elf", true),
    Question("Maryland is on the Atlantic Ocean", true),
    Question("Hawaii is a State in America", true),
    Question("Paper can be used for writing?", true),
    Question("There are 50 letters in the Alphebet", false),
    Question("PI is 3.14", true),
    Question("Drums are a musical instrument", true),
    Question("Apple is a computer company", true),
  ];

  String getQuestionText() {
    return _questionBank[_questionIndex].questionText;
  }

  bool getQuestionAnswer() {
    return _questionBank[_questionIndex].questionAnswer;
  }

  int getQuestionBankLength() {
    return _questionBank.length - 1;
  }

  void setNewQuestion(int index, String text, bool answer) {
    _questionBank.insert(index, Question("$text", answer));
  }

  void resetQuizIndex() {
    _questionIndex = 0;
  }

  void goBack() {
    _questionIndex -= 1;
  }

  bool hasRemainingQuestions() {
    if (_questionIndex < getQuestionBankLength()) {
      return true;
    } else {
      return false;
    }
  }

  void updateQuestionNumber() {
    if (_questionIndex < getQuestionBankLength()) {
      _questionIndex += 1;
    } else {
      setNewQuestion(0, "All Questions answered!", true);
      _questionIndex = 0;
    }
  }
}
