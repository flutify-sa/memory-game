import 'package:flutter/material.dart';

class MemoryGameProvider extends ChangeNotifier {
  List<String> cardImages = [
    'assets/apple.png',
    'assets/apple.png',
    'assets/banana.png',
    'assets/banana.png',
    'assets/cherry.png',
    'assets/cherry.png',
    'assets/grape.png',
    'assets/grape.png',
  ];

  List<bool> flippedCards = List.filled(8, false);
  List<int> selectedIndexes = [];
  int score = 0;

  MemoryGameProvider() {
    cardImages.shuffle();
  }

  void resetGame() {
    cardImages.shuffle(); // Shuffle cards again
    flippedCards = List.filled(cardImages.length, false); // Reset flips
    selectedIndexes.clear();
    score = 0;
    notifyListeners(); // Update UI
  }

  void flipCard(int index) {
    if (!flippedCards[index] && selectedIndexes.length < 2) {
      selectedIndexes.add(index);
      flippedCards[index] = true;
      notifyListeners();

      if (selectedIndexes.length == 2) {
        Future.delayed(Duration(seconds: 1), checkMatch);
      }
    }
  }

  void checkMatch() {
    if (cardImages[selectedIndexes[0]] == cardImages[selectedIndexes[1]]) {
      score++;
    } else {
      flippedCards[selectedIndexes[0]] = false;
      flippedCards[selectedIndexes[1]] = false;
    }
    selectedIndexes.clear();
    notifyListeners();
  }
}
