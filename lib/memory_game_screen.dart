import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_game_provider.dart';
import 'memory_card.dart';

class MemoryGameScreen extends StatelessWidget {
  const MemoryGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<MemoryGameProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          // Background Image covering the entire screen
          Positioned.fill(
            child: Image.asset(
              'assets/blue.png',
              fit: BoxFit.cover, // Ensures full coverage
            ),
          ),

          // Game UI Layer
          Column(
            children: [
              AppBar(
                title: Text("Memory Game"),
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                centerTitle: true,
                elevation: 4.0,
                actions: [
                  IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => game.resetGame(), // Calls reset function
                  ),
                ],
              ),

              SizedBox(height: 20),
              Text(
                "Score: ${game.score}",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              // Centered Grid
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: GridView.builder(
                      shrinkWrap: true, // Keeps the grid compact
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4, // Number of columns
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6,
                        childAspectRatio: 2 / 3, // Adjusts card shape
                      ),
                      itemCount: game.cardImages.length,
                      itemBuilder: (context, index) {
                        return MemoryCard(
                          imagePath: game.cardImages[index],
                          isFlipped: game.flippedCards[index],
                          onTap: () => game.flipCard(index),
                        );
                      },
                    ),
                  ),
                ),
              ),
              // Footer Row
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/valknut.png', width: 40, height: 40),
                    SizedBox(width: 10),
                    Text(
                      'Built by Flutify.co.za',
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Flutify',
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
