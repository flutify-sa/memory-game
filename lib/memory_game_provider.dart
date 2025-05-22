import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MemoryGameProvider extends ChangeNotifier {
  int gridSize = 4;
  int totalCards = 16;
  int totalFlips = 0;
  int score = 0; // Added score tracking

  List<String> cardImages = [];
  List<bool> flippedCards = [];
  List<int> selectedIndexes = [];

  final List<String> allImages = [
    'assets/apple.png',
    'assets/apple.png',
    'assets/banana.png',
    'assets/banana.png',
    'assets/cherry.png',
    'assets/cherry.png',
    'assets/grape.png',
    'assets/grape.png',
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
    _loadGameState(); // Load saved stats
  }

  Future<void> _loadGameState() async {
    final prefs = await SharedPreferences.getInstance();
    gridSize = prefs.getInt("gridSize") ?? 4;
    totalFlips = prefs.getInt("totalFlips") ?? 0;
    score = prefs.getInt("score") ?? 0;
    notifyListeners();
    _initializeGame(); // Ensure the game loads correctly
  }

  Future<void> _saveGameState() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt("gridSize", gridSize);
    prefs.setInt("totalFlips", totalFlips);
    prefs.setInt("score", score);
  }

  void _initializeGame() {
    totalCards = gridSize * gridSize;
    totalFlips = 0;
    score = 0;

    if (totalCards > allImages.length) {
      debugPrint("⚠️ Grid size exceeds available images. Adjusting...");
      totalCards = allImages.length;
    }

    cardImages = List.from(allImages.sublist(0, totalCards));
    cardImages.shuffle();
    flippedCards = List.filled(totalCards, false);
    selectedIndexes.clear();
    notifyListeners();
  }

  void setDifficulty(int size) {
    gridSize = size;
    _initializeGame();
    _saveGameState(); // Ensure settings persist
    notifyListeners();
  }

  void resetGame() {
    totalFlips = 0;
    score = 0;
    _initializeGame();
    _saveGameState();
    notifyListeners();
  }

  int get minPossibleFlips => totalCards;

  void flipCard(int index) {
    if (!flippedCards[index] && selectedIndexes.length < 2) {
      selectedIndexes.add(index);
      flippedCards[index] = true;
      totalFlips++;
      notifyListeners();
      _saveGameState(); // Save flip count

      // Check for a match only when 2 cards are flipped
      if (selectedIndexes.length == 2) {
        Future.delayed(const Duration(seconds: 1), () {
          if (selectedIndexes.isNotEmpty) {
            checkMatch();
          }
        });
      }
    }
  }

  void checkMatch() {
    if (selectedIndexes.length < 2) {
      debugPrint("⚠️ Error: Not enough selected cards to check a match.");
      return;
    }

    int firstIndex = selectedIndexes[0];
    int secondIndex = selectedIndexes[1];

    if (firstIndex < 0 ||
        firstIndex >= cardImages.length ||
        secondIndex < 0 ||
        secondIndex >= cardImages.length) {
      debugPrint("⚠️ Error: Index out of range.");
      return;
    }

    if (cardImages[firstIndex] == cardImages[secondIndex]) {
      score++; // Increase score for correct match
      _saveGameState(); // Persist updated score
    } else {
      flippedCards[firstIndex] = false;
      flippedCards[secondIndex] = false;
    }

    selectedIndexes.clear();
    notifyListeners();
  }
}
