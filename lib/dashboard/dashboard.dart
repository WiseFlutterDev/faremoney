import 'package:flutter/material.dart';
import 'package:faremoney/dashboard/home/home.dart';
import 'package:faremoney/core/styles.dart';

void main() {
  runApp(const Dashboard());
}

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: true,
      home: Container(
        color: Colors.black, // Set the background color of the container to black
        child: const HomeScreen(),
      ),
    );
  }
}
