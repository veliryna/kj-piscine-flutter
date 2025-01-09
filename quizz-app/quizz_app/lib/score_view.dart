import 'package:flutter/material.dart';

class ScorePage extends StatelessWidget{
  const ScorePage({super.key, required this.score, required this.name});
  final int score;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Your Score In $name QUIZ:",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            Text(
              "$score",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold, color: Colors.limeAccent.shade700),
            ),
            const SizedBox(height: 30,),
            OutlinedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.lightGreenAccent,
                backgroundColor: Colors.transparent,
                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                elevation: 5.0,
              ),
              onPressed: () => {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false)
              },
              child: Text('BACK TO MAIN PAGE', style: TextStyle(color: Colors.green.shade900)),
            ),
          ],
        ),
      ),
    );
  }
}