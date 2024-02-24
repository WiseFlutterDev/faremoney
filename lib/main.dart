import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:faremoney/core/styles.dart';
import 'package:faremoney/on-boarding/on_boarding_page.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const WalletApp());
}

class WalletApp extends StatelessWidget {
  const WalletApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'faremoney',
      theme: ThemeData(
        // Define your custom colors here

      ),
      home: const OnBoardingPage(),
    );
  }
}
