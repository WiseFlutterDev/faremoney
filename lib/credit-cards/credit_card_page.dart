// todo ths is when you click a card page it shows you the card and transaction histore

import 'package:flutter/material.dart';
import 'package:faremoney/core/constants.dart';
import 'package:faremoney/core/data.dart';
import 'package:faremoney/core/styles.dart';
import 'package:faremoney/credit-cards/credit_card.dart';
import 'package:faremoney/on-boarding/on_boarding_page.dart';

class CreditCardPage extends StatefulWidget {
  const CreditCardPage({
    required this.initialIndex,
    required this.pageTransitionAnimation,
    super.key,
  });

  final int initialIndex;
  final Animation<double> pageTransitionAnimation;

  @override
  State<CreditCardPage> createState() => _CreditCardPageState();
}

class _CreditCardPageState extends State<CreditCardPage> {
  late final Animation<Offset> slideAnimation;
  late final PageController pageController;
  late int activeIndex;

  @override
  void initState() {
    super.initState();
    pageController = PageController(
      initialPage: widget.initialIndex,
      viewportFraction: 0.85,
    );
    activeIndex = widget.initialIndex;
    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: widget.pageTransitionAnimation,
        curve: Curves.easeOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        title: Text(cards[activeIndex].name),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(activeIndex),
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            clipBehavior: Clip.hardEdge,
            child: Column(
              children: [
                _buildCardsPageView(context),
                SlideTransition(
                  position: slideAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        PageIndicator(
                          length: cards.length,
                          activeIndex: activeIndex,
                          activeColor: cards[activeIndex].style.color,
                        ),
                        _buildButtons(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SlideTransition(
                position: slideAnimation,
                child: _buildLatestTransactionsSection(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsPageView(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final cardWidth = screenSize.width - Constants.appHPadding * 2;
    return SizedBox(
      height: cardWidth / creditCardAspectRatio,
      child: PageView.builder(
        controller: pageController,
        itemCount: cards.length,
        onPageChanged: (index) => setState(() => activeIndex = index),
        itemBuilder: (context, index) {
          return AnimatedScale(
            scale: index == activeIndex ? 1 : 0.85,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: HeroMode(
              enabled: index == activeIndex,
              child: Hero(
                tag: 'card_${cards[index].id}',
                child: CreditCard(
                  width: cardWidth,
                  data: cards[1],
                  isFront: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildButtons() {
    return Row(
      children: [
        Expanded(
          child: _Button(
            label: 'Rate',
            icon: Icons.star,
            onTap: () {
              print('thanks for rating');
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _Button(
            label: 'pay',
            icon: Icons.send,
            onTap: () {
              print('here is the pay button');
            },
          ),
        ),
      ],
    );
  }

  Widget _buildLatestTransactionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 15),
        const Text(
          'Latest Transactions',
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 15),
        ...List.generate(
          transactions.length,
          (index) => _TransactionItem(
            transactions[index],
          ),
        ),
        SizedBox(height: MediaQuery.of(context).padding.bottom),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.label,
    required this.icon,
    this.onTap,
  });

   final String label;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.onBlack,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              width: 50,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 20),
             Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  label,
                  style: const TextStyle(color: AppColors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TransactionItem extends StatelessWidget {
  const _TransactionItem(this.transaction);

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.onWhite,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              transaction.icon,
              width: 60,
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.title,
                  style: const TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                Text(
                  transaction.date,
                  style: const TextStyle(color: AppColors.onBlack),
                ),
              ],
            ),
          ),
          Text(
            (transaction.amount < 0 ? '' : '+') + transaction.amount.toString(),
            style: TextStyle(
              color:
                  transaction.amount < 0 ? AppColors.danger : AppColors.primary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
