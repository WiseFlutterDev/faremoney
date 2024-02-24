import 'dart:ui';

import 'package:faremoney/dashboard/model.dart';
import 'package:flutter/material.dart';
import "package:faremoney/dashboard/pages/send.dart";
import "package:faremoney/dashboard/pages/qrcodePage.dart";
import "package:faremoney/dashboard/pages/fund_wallet.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  String username = "Olusi";
  String welcome = "Welcome Back!";
  String value = "20,000";
  final controller = ScrollController();

  bool isgoodornot = false;

  List accounts = [
    MyList(
        title: "sole.prime",
        subtitle: "2022-08-21 02:14:12",
        money: "\$250",
        isgood: false),
    MyList(
        title: "destiny",
        subtitle: "2022-07-12 05:07:12",
        money: "\$100",
        isgood: false),
    MyList(
        title: "socrates",
        subtitle: "2022-05-20 07:12:12",
        money: "\$100",
        isgood: true),
    MyList(
        title: "edegx",
        subtitle: "2022-05-14 03:33:22",
        money: "\$300",
        isgood: true),
    MyList(
        title: "youkay",
        subtitle: "2022-05-04 01:32:14",
        money: "\$700",
        isgood: false)
  ];

  int _pageindex = 0;

  void onPageChanged(int index) {
    setState(() {
      _pageindex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set the background color to black
      resizeToAvoidBottomInset: true,
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Hello $username",
                          style: const TextStyle(
                              color: Colors.white30, fontSize: 22),
                        ),
                        Text(
                          welcome,
                          style: const TextStyle(
                              color: Colors.white60,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ]),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: IconButton(
                      onPressed: () {},
                      icon: const Stack(
                        children: [
                          Icon(
                            Icons.notifications_none_outlined,
                            size: 24,
                            color: Colors.white60,
                          ),
                          Positioned(
                            left: 14,
                            child: Icon(
                              Icons.brightness_1,
                              color: Colors.red,
                              size: 9.0,
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  colors: [
                    Colors.black,
                    Colors.black,
                    Colors.black26,
                    Colors.lightBlue,
                    Colors.lightBlue,
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 20, top: 20),
                        child: Text(
                          "Current balance",
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        "\$ $value",
                        style: const TextStyle(
                            color: Colors.white, fontSize: 25),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                        child: Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.9),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomCenter,
                              colors: [Colors.white60, Colors.white10],
                            ),
                            borderRadius: BorderRadius.circular(10),
                            border:
                            Border.all(width: 2, color: Colors.white60),
                          ),
                          child: IconButton(
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.add,
                              size: 37,
                              color: Colors.white60,
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => fund_wallet()),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tiles(Icons.send, Colors.orange, Colors.purpleAccent, "Send",
                    context, const SendMoneyPage()),
                _tiles(Icons.money, Colors.orange, Colors.greenAccent,
                    "Withdraw", context, const SendMoneyPage()),
                _tiles(Icons.monetization_on_outlined, Colors.orange,
                    Colors.blueAccent, "Donate", context, const SendMoneyPage()),
                _tiles(Icons.sim_card_outlined, Colors.orange, Colors.indigo,
                    //TODO QRCODE PAGE CALL
                    "View QR", context, const QRCodePage(data: '1234567890')),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tiles(Icons.arrow_downward, Colors.blueGrey, Colors.red,
                    "Lend", context, const SendMoneyPage()),
                _tiles(Icons.note_alt_outlined, Colors.blueGrey, Colors.green,
                    "Statement", context, const SendMoneyPage()),
                _tiles(Icons.paypal, Colors.blueGrey, Colors.purpleAccent,
                    "Pay Bills", context, const SendMoneyPage()),
                _tiles(Icons.currency_exchange, Colors.blueGrey,
                    Colors.deepPurple, "Loan", context, const SendMoneyPage()),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    "Recent transactions",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: TextButton(
                      style: ButtonStyle(
                        overlayColor:
                        MaterialStateProperty.all(Colors.transparent),
                      ),
                      onPressed: () {},
                      child: const Text(
                        "See all",
                        // todo this is the see al section
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 15,
                        ),
                      )),
                ),
              ],
            ),
            Expanded(
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ScrollConfiguration(
                  behavior: const MaterialScrollBehavior()
                      .copyWith(overscroll: false),
                  child: ListView.builder(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: accounts.length,
                      itemBuilder: (context, index) {
                        bool isornot = accounts[index].isgood;

                        return ListTile(
                          title: Text(
                            accounts[index].title,
                            style: const TextStyle(
                                color: Colors.white70,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          subtitle: Text(accounts[index].subtitle,
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13)),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                accounts[index].money,
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              isornot == false
                                  ? const Icon(Icons.arrow_downward_outlined,
                                  color: Colors.red)
                                  : const Icon(Icons.arrow_upward_outlined,
                                color: Colors.green,),
                            ],
                          ),
                        );
                      }),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SingleChildScrollView(
        //TODO BOTTOM PART OF THE DASHBOARD
        child: Container(
          height: 70,
          color: Colors.transparent,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              canvasColor: Colors.transparent,
            ),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              elevation: 0.0,
              selectedIconTheme: const IconThemeData(
                size: 18,
                color: Color(0xFF00E5FF),
              ),
              iconSize: 15,
              unselectedItemColor: Colors.black87,
              unselectedFontSize: 10,
              selectedFontSize: 15,
              currentIndex: _pageindex,
              onTap: onPageChanged,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.replay_5_outlined),
                  label: "Schedule",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.credit_card),
                  label: "Card",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined),
                  label: "Profile",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Container _tiles(IconData icon, Color color1, color2, String title,
    BuildContext context, Widget page) {
  return Container(
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        height: 70,
        width: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.9),
              spreadRadius: 3,
              blurRadius: 3,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          gradient: LinearGradient(
            colors: [
              color1,
              color2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListTile(
          title: Icon(
            icon,
            size: 30,
            color: Colors.white70,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    ),
  );
}
