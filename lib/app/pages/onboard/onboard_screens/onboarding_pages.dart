import 'package:flutter/material.dart';

class OnboardingPages extends StatelessWidget {
  final String headline;
  const OnboardingPages({super.key, required this.headline});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      margin: EdgeInsets.only(top: height * 0.23),
      child: Text(
        headline,
        style: Theme.of(context).textTheme.displayLarge!.copyWith(
              color: const Color(0XFF9ee6bf),
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}
