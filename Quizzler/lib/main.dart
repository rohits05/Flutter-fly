// import 'dart:html';

import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'question.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizBrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          backgroundColor: Colors.deepOrange,
          title: Text(
            'Welcome to Qu❔zzler ..          🤔',
            style: TextStyle(
                letterSpacing: 0.0,
                fontSize: 20.0,
                fontFamily: 'Kalam',
                fontWeight: FontWeight.w700,
                shadows: <Shadow>[
                  Shadow(
                      offset: Offset(0.0, -4.0),
                      blurRadius: 20.0,
                      color: Colors.black)
                ]),
          ),
        ),
        backgroundColor: Colors.white,
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

  // List<String> questions = [
  //   "Does a hen have 3 legs",
  //   "Is the sky is glossy",
  //   "Does Spidy will defeat all of the villians in No Way Home",
  // ];
  // Question q1 = Question(q: "Does a hen have 3 legs", a: false);
  // List<bool> answers = [
  //   false,
  //   true,
  //   true,
  // ];
  // List<Question> questionBank = [
  //   Question(q: "Does a hen have 3 legs", a: false),
  //   Question(q: "Is the sky is glossy", a: true),
  // ];

  void checkAnswer(bool userPickedAnswer) {
    bool correct = quizBrain.getCorrectAnswer();

    setState(() {
      if (quizBrain.isFinished() == true) {
        //TODO Step 4 Part A - show an alert using rFlutter_alert,

        //This is the code for the basic alert from the docs for rFlutter Alert:
        //Alert(context: context, title: "RFLUTTER", desc: "Flutter is awesome.").show();

        //Modified for our purposes:
        Alert(
          context: context,
          title: '🎉  Finished !! 🏁',
          desc: 'You\'ve reached the end of the quiz.',
        ).show();

        //TODO Step 4 Part C - reset the questionNumber,
        quizBrain.reset();

        //TODO Step 4 Part D - empty out the scoreKeeper.
        scoreKeeper = [];
      } else {
        if (userPickedAnswer == correct) {
          scoreKeeper.add(Icon(Icons.check, color: Colors.teal));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.amber));
        }

        quizBrain.nextQuestion();
        // scoreKeeper.add(Icon(
        //   Icons.check,
        //   color: Colors.teal,
        // ));
      }
    });
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
                    color: Colors.grey.shade700,
                    fontFamily: 'Courgette',
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 20.0,
                          color: Colors.grey.shade500)
                    ]),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15.0),
          child: Container(
              height: 2.5,
              // width: 5.0,
              color: Colors.grey.shade500,
              child: VerticalDivider(
                color: Colors.grey,
              )),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular((30.0)))),
              enableFeedback: false,
              textColor: Colors.white,
              color: Colors.tealAccent.shade700,
              child: Text(
                'True',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 35.0,
                    fontFamily: 'Kings',
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(7.0, 7.0),
                          blurRadius: 10.0,
                          color: Colors.grey.shade700)
                    ]),
              ),
              onPressed: () {
                checkAnswer(true);
              },
            ),
          ),
        ),
        Container(
            height: 15.0,
            // color: Colors.grey.shade700,
            child: VerticalDivider(
              color: Colors.black,
              thickness: 1.0,
            )),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular((30.0)))),
              enableFeedback: false,
              hoverColor: Colors.red,
              color: Colors.amber.shade400,
              child: Text(
                'False',
                style: TextStyle(
                    fontSize: 35.0,
                    color: Colors.white,
                    fontFamily: 'Kings',
                    fontWeight: FontWeight.bold,
                    shadows: <Shadow>[
                      Shadow(
                          offset: Offset(7.0, 7.0),
                          blurRadius: 10.0,
                          color: Colors.grey.shade700)
                    ]),
              ),
              onPressed: () {
                checkAnswer(false);
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 5.0),
          child: Container(
              height: 1.5,
              // width: 5.0,
              color: Colors.grey.shade500,
              child: VerticalDivider(
                color: Colors.grey,
              )),
        ),
        Row(
          children: scoreKeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
