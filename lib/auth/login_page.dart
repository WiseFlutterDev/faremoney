import 'dart:math';
import 'package:faremoney/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:faremoney/core/data.dart';
import 'package:faremoney/core/styles.dart';
import 'package:faremoney/core/widgets/wallet.dart';
import 'package:faremoney/auth/registration_page.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'auth_models/login_model.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> rotationAnimation;
  late final PageController pageController;
  static const viewportFraction = 0.7;
  int activeIndex = 0;
  bool _loading = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    pageController = PageController(viewportFraction: viewportFraction);
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    final curvedAnimation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeOut,
    );
    rotationAnimation =
        Tween<double>(begin: 0, end: 30 * pi / 180).animate(curvedAnimation);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final itemWidth = screenSize.width * viewportFraction;

    return _loading
        ? Center(child: CircularProgressIndicator())
        : Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 40),
            Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                      'FAREMONEY',
                      textStyle: TextStyle(
                          color: Color(0xFF740362),
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                ],
                isRepeatingAnimation: true,
                pause: const Duration(milliseconds: 1000),
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
                onTap: () {
                  print("Tap Event");
                },
              ),
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  const Positioned(
                    left: -250 + 40,
                    width: 250,
                    top: -32,
                    bottom: -32,
                    child: WalletSide(),
                  ),
                  Positioned.fill(
                    child: GestureDetector(
                      onTapDown: (_) => animationController.forward(),
                      onTapUp: (_) => animationController.reverse(),
                      child: PageView.builder(
                        controller: pageController,
                        itemCount: onBoardingItems.length,
                        onPageChanged: (int index) {
                          setState(() {
                            activeIndex = index;
                          });
                          animationController.forward().then(
                                (value) => animationController.reverse(),
                          );
                        },
                        itemBuilder: (context, index) {
                          return AnimatedScale(
                            duration: const Duration(milliseconds: 300),
                            scale: index == activeIndex ? 1 : 0.8,
                            curve: Curves.easeOut,
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColors.onBlack,
                                borderRadius: BorderRadius.circular(25),
                                image: DecorationImage(
                                  image: AssetImage(
                                    onBoardingItems[index].image,
                                  ),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: -250 + 35,
                    width: 250,
                    top: -30,
                    bottom: -30,
                    child: AnimatedBuilder(
                      animation: animationController,
                      builder: (context, child) {
                        return Transform(
                          transform: Matrix4.identity()
                            ..setEntry(3, 2, 0.001)
                            ..rotateY(rotationAnimation.value),
                          alignment: Alignment.center,
                          child: const WalletSide(),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: (screenSize.width - itemWidth) / 2,
                right: (screenSize.width - itemWidth) / 2,
                top: 40,
                bottom: 50,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                      const Color(0xFF740362), // Set the background color of the button
                    ),
                    onPressed: () async {
                      setState(() {
                        _loading = true;

                      });

                      // Retrieve the values entered in the TextFields
                      String email = _emailController.text;
                      String password = _passwordController.text;
                      bool? result = await  loginUser(email, password);
                      if(result == true){
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => const Dashboard(),
                          ),
                        );
                      }else{
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                      // Print the email and password to the console
                      print('Email: $email');
                      print('Password: $password');

                      // Simulate a network request delay
                      await Future.delayed(Duration(seconds: 1));

                      setState(() {
                        _loading = false;
                      });
                    },
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (context) => const CreateAccountPage(),
                        ),
                      );
                    },
                    child: const Text('Create an account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
