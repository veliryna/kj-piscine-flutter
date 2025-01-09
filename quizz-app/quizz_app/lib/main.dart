import 'package:flutter/material.dart';
import 'package:quizz_app/models/quiz.dart';
import 'package:quizz_app/detailed_view.dart';

Quiz myQuiz = Quiz();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MainPage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Quiz App",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(myQuiz.quiz.length, (index) {
          return MaterialButton(
            padding: const EdgeInsets.all(8.0),
            elevation: 8.0,
            onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(category: myQuiz.quiz[index]),
                  ),
                );
              },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: AssetImage(myQuiz.quiz[index].imageUrl),
                  fit: BoxFit.cover,
                ),
              ),

              child: Center(
                child: Text(
                  myQuiz.quiz[index].title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.yellowAccent,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );

        }),
      )
    );
  }
}