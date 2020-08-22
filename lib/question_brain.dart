import 'package:quizzler/question.dart';

class QuestionBrain {
  int _questionNumber = 0;

  List<Question> _questionBank = [
    Question('The square root of 100 is five.', false),
    Question('Water is also called H2O.', true),
    Question('Ice is made out of glass.', false),
    Question('The fifth planet away from the sun in the solar system is Mars.', false),
    Question('If you mix all the colors of the rainbow together, you get white.', true)
  ];

  int nextQuestion() {
    if(_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }

    return _questionNumber;
  }

  String getQuestion() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getAnswer() {
    return _questionBank[_questionNumber].answer;
  }

  bool isFinished() {
    if(_questionNumber >= _questionBank.length -1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    _questionNumber = 0;
  }

}