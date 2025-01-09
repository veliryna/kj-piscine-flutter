import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

MaterialApp myApp() {
  return MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('BizzCard'),
        backgroundColor: Colors.blueAccent,
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 80, backgroundImage: AssetImage('images/avatar.jpg'),),
            SizedBox(height: 10),
            Text("Iryna Velychko", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            Text("21 years old", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text("velira77@gmail.com", style: TextStyle(fontSize: 20)),
            Text("+38 095-120-16-26", style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    ),
    debugShowCheckedModeBanner: false,
  );
}