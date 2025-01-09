import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

void main() {
  runApp(const BouncerApp());
}

class BouncerApp extends StatelessWidget {
  const BouncerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Bouncer',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          ),
          backgroundColor: Colors.yellowAccent,
        ),
        body: const BouncingGame(),
      ),
    );
  }
}

class BouncingGame extends StatefulWidget {
  const BouncingGame({super.key});

  @override
  BouncingGameState createState() => BouncingGameState();
}

class BouncingGameState extends State<BouncingGame> {
  static const double ballRadius = 20.0;
  static const double blockSize = 50.0;
  static const double playerTileWidth = 80.0;
  static const double playerTileHeight = 20.0;
  static const double initialSpeed = 2.0;
  static const int numBlocksPerRow = 5;
  static const int numBlocksRows = 4;

  double screenWidth = 0.0;
  double screenHeight = 0.0;
  double playerX = 0.0;
  double ballX = 0.0;
  double ballY = 0.0;
  double ballSpeedX = initialSpeed;
  double ballSpeedY = initialSpeed;
  List<Offset> blockOffsets = [];

  late StreamSubscription<AccelerometerEvent> accelerometer;

  @override
  void initState() {
    super.initState();
    accelerometer = accelerometerEventStream().listen((AccelerometerEvent event) {
      setState(() {
        playerX -= event.y * 2;
        if (playerX < 0) {
          playerX = 0;
        } else if (playerX > screenWidth - playerTileWidth) {
          playerX = screenWidth - playerTileWidth;
        }
      });
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      screenWidth = MediaQuery.of(context).size.width;
      screenHeight = MediaQuery.of(context).size.height;
      playerX = (screenWidth - playerTileWidth) / 2;
      ballX = screenWidth / 2;
      ballY = screenHeight / 2;
      generateBlocks();
      startGameLoop();
    });
  }

  @override
  void dispose() {
    accelerometer.cancel();
    super.dispose();
  }

  void generateBlocks() {
    double blockWidth = screenWidth / numBlocksPerRow;
    double blockHeight = blockSize;
    for (int i = 0; i < numBlocksRows; i++) {
      for (int j = 0; j < numBlocksPerRow; j++) {
        blockOffsets.add(Offset(j * blockWidth, i * blockHeight));
      }
    }
  }

  void startGameLoop() {
    Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {
        // Ball movement
        ballX += ballSpeedX;
        ballY += ballSpeedY;

        // Ball collision
        if (ballX <= 0 || ballX >= screenWidth - ballRadius * 2) {
          ballSpeedX *= -1;
        }
        if (ballY <= 0) {
          ballSpeedY *= -1;
        }
        if (ballY >= screenHeight - ballRadius * 2) {
          timer.cancel();
          showLostDialog();
        }

        Rect ballRect = Rect.fromCircle(center: Offset(ballX, ballY), radius: ballRadius);
        for (int i = 0; i < blockOffsets.length; i++) {
          Rect blockRect = Rect.fromPoints(blockOffsets[i], blockOffsets[i] + Offset(screenWidth/numBlocksPerRow, blockSize));
          if (ballRect.overlaps(blockRect)) {
            ballSpeedY *= -1;
            blockOffsets.removeAt(i);
            if (blockOffsets.isEmpty) {
              timer.cancel();
              showWonDialog();
            }
            break;
          }
        }
      });
    });
  }

  void showLostDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You Lost!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  restartGame();
                });
              },
              child: const Text("RESTART"),
            ),
          ],
        );
      },
    );
  }

  void showWonDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("You Won!"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  restartGame();
                });
              },
              child: const Text("RESTART"),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    ballX = screenWidth / 2;
    ballY = screenHeight / 2;
    ballSpeedX = initialSpeed;
    ballSpeedY = initialSpeed;
    blockOffsets.clear();
    generateBlocks();
    startGameLoop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeInOut,
          left: playerX,
          bottom: 0,
          child: Container(
            width: playerTileWidth,
            height: playerTileHeight,
            color: Colors.blue,
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 16),
          left: ballX,
          top: ballY,
          child: Container(
            width: ballRadius * 2,
            height: ballRadius * 2,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black,
            ),
          ),
        ),
        for (var offset in blockOffsets)
          Positioned(
            left: offset.dx,
            top: offset.dy,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.lightGreen.shade300,
                  border: Border.all(
                    color: Colors.grey.shade700,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.green.shade700,
                      spreadRadius: 4,
                      blurRadius: 10,
                    ),
                  ]
              ),
              width: screenWidth/numBlocksPerRow,
              height: blockSize,
            ),
          ),
      ],
    );
  }
}
