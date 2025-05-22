import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_game_provider.dart';
import 'memory_card.dart';

class MemoryGameScreen extends StatelessWidget {
  const MemoryGameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset('assets/bg.png', fit: BoxFit.cover),
          ),
          Column(
            children: [
              AppBar(
                title: const Text(
                  "Memory Game",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.5,
                  ),
                ),
                centerTitle: true,
                backgroundColor: Colors.transparent,
                foregroundColor: Colors.white,
                elevation: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Consumer<MemoryGameProvider>(
                      builder:
                          (context, game, child) => DropdownButton<int>(
                            value: game.gridSize,
                            dropdownColor: Colors.deepPurple,
                            icon: const Icon(
                              Icons.grid_on,
                              color: Colors.white,
                            ),
                            underline: SizedBox(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                            items:
                                [2, 4, 6].map((size) {
                                  return DropdownMenuItem<int>(
                                    value: size,
                                    child: Text("$size x $size"),
                                  );
                                }).toList(),
                            onChanged: (size) {
                              game.setDifficulty(size!);
                            },
                          ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh, size: 30),
                    onPressed:
                        Provider.of<MemoryGameProvider>(
                          context,
                          listen: false,
                        ).resetGame,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // TextField displaying grid stats
              Consumer<MemoryGameProvider>(
                builder:
                    (context, game, child) => Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: SizedBox(
                        width: double.infinity,
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          maxLines: 3,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(200, 50, 50, 50),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 12,
                            ),
                            hintText:
                                "Grid: ${game.gridSize} x ${game.gridSize}\nTotal Flips: ${game.totalFlips}\nMin Flips: ${game.minPossibleFlips}",
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
              ),

              const SizedBox(height: 20),

              // Centered Grid with Safe Handling
              Expanded(
                child: Consumer<MemoryGameProvider>(
                  builder: (context, game, child) {
                    // Ensure data is ready before building grid
                    if (game.cardImages.isEmpty || game.flippedCards.isEmpty) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Show loading until initialized
                      );
                    }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: game.gridSize,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                        itemCount: game.totalCards,
                        itemBuilder: (context, index) {
                          return MemoryCard(
                            imagePath: game.cardImages[index],
                            isFlipped: game.flippedCards[index],
                            onTap: () => game.flipCard(index),
                          );
                        },
                      ),
                    );
                  },
                ),
              ),

              // Footer
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/valknut.png', width: 40, height: 40),
                    const SizedBox(width: 10),
                    const Text(
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
