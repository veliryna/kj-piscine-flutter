import 'package:flutter/material.dart';
import 'package:quizz_app/models/category.dart';
import 'package:quizz_app/score_view.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key, required this.category});
  final CategoryItem category;

  @override
  QuizPageState createState() => QuizPageState(quizData: category);
}

class QuizPageState extends State<QuizPage>{
  int currentQuestionIndex = 0;
  int userScore = 0;
  bool _showResult = false;
  bool _userAnswer = false;
  final CategoryItem quizData;

  QuizPageState({required this.quizData});

  void _checkAnswer(bool userAnswer) {
    bool correctAnswer = quizData.questions[currentQuestionIndex].answer;
    setState(() {
      _userAnswer = userAnswer;
      if (_userAnswer == correctAnswer) {
        userScore++;
        const snackBar = SnackBar(
          content: Text('Correct!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(seconds: 1, milliseconds: 500)).then((val) {
          _showResult = true;
          _nextQuestion();
        });
      } else {
        const snackBar = SnackBar(
          content: Text('Incorrect!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Future.delayed(const Duration(seconds: 1, milliseconds: 500)).then((val) {
          _showResult = true;
          _nextQuestion();
        });
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (currentQuestionIndex == quizData.questions.length - 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScorePage(score: userScore, name: quizData.title),
          ),
        );
      } else {
        _showResult = false;
        currentQuestionIndex++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: const Size.fromHeight(300.0),
        child: Container(
          height: 300.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            image: DecorationImage(
              image: AssetImage(quizData.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child:Text(
                quizData.questions[currentQuestionIndex].question,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 20.0),
            if (!_showResult)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurpleAccent,
                      backgroundColor: Colors.greenAccent.shade700,
                      elevation: 5.0,
                    ),
                    onPressed: () => _checkAnswer(true),
                    child: const Text('TRUE', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                  ),
                  const SizedBox(width: 20.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.pinkAccent.shade700,
                      backgroundColor: Colors.redAccent.shade700,
                      elevation: 5.0,
                    ),
                    onPressed: () => _checkAnswer(false),
                    child: const Text('FALSE', style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}