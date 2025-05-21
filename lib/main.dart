import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'memory_game_screen.dart';
import 'memory_game_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => MemoryGameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Memory Card Game',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Flutify', // Correct placement inside ThemeData
        ),
        home: MemoryGameScreen(),
      ),
    ),
  );
}
