import 'package:flutter/material.dart';
import 'package:webtoon/screens/home_screen.dart';
// import 'package:webtoon/services/api_services.dart';

void main() {
  // ApiService.getTodaysToons();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}
