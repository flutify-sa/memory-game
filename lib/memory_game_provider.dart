import 'package:flutter/material.dart';

class MemoryGameProvider extends ChangeNotifier {
  int gridSize = 4; // Default size
  int totalCards = 16;

  List<String> cardImages = [];
  List<bool> flippedCards = [];
  List<int> selectedIndexes = [];
  int score = 0;

  final List<String> allImages = [
    'assets/apple.png',
    'assets/apple.png',
    'assets/banana.png',
    'assets/banana.png',
    'assets/cherry.png',
    'assets/cherry.png',
    'assets/grape.png',
    'assets/grape.png',
    'assets/orange.png',
    'assets/orange.png',
    'assets/strawberry.png',
    'assets/strawberry.png',
    'assets/blueberry.png',
    'assets/blueberry.png',
    'assets/coconut.png',
    'assets/coconut.png',
    'assets/kiwi.png',
    'assets/kiwi.png',
    'assets/lemon.png',
    'assets/lemon.png',
    'assets/mango.png',
    'assets/mango.png',
    'assets/peach.png',
    'assets/peach.png',
    'assets/pear.png',
    'assets/pear.png',
    'assets/pineapple.png',
    'assets/pineapple.png',
    'assets/plum.png',
    'assets/plum.png',
    'assets/raspberry.png',
    'assets/raspberry.png',
    'assets/watermelon.png',
    'assets/watermelon.png',
  ];

  MemoryGameProvider() {
    _initializeGame();
  }

  void _initializeGame() {
    totalCards = gridSize * gridSize;

    // Ensure enough images exist
    if (totalCards > allImages.length) {
      debugPrint(
        "⚠️ Warning: Grid size exceeds available images. Adjusting...",
      );
      totalCards = allImages.length; // Prevents crashes
    }

    cardImages = List.from(allImages.sublist(0, totalCards));
    cardImages.shuffle();
    flippedCards = List.filled(totalCards, false);
    selectedIndexes.clear();
    score = 0;
    notifyListeners();
  }

  void setDifficulty(int size) {
    gridSize = size;
    totalCards = gridSize * gridSize;
    _initializeGame(); // Ensures proper list reallocation
    notifyListeners(); // Forces UI refresh
  }

  void resetGame() {
    _initializeGame();
  }

  void flipCard(int index) {
    if (!flippedCards[index] && selectedIndexes.length < 2) {
      selectedIndexes.add(index);
      flippedCards[index] = true;
      notifyListeners();

      if (selectedIndexes.length == 2) {
        Future.delayed(const Duration(seconds: 1), checkMatch);
      }
    }
  }

  void checkMatch() {
    if (selectedIndexes.length == 2 &&
        cardImages[selectedIndexes[0]] == cardImages[selectedIndexes[1]]) {
      score++;
    } else {
      flippedCards[selectedIndexes[0]] = false;
      flippedCards[selectedIndexes[1]] = false;
    }
    selectedIndexes.clear();
    notifyListeners();
  }
}
