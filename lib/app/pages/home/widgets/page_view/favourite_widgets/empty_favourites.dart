import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class EmptyFavourites extends StatelessWidget {
  const EmptyFavourites({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LottieBuilder.asset(
            "assets/lottie/heart_react.json",
            height: 400,
            width: 400,
            repeat: false,
          ),
          Text(
            "Start Filling Up Your Favorites!",
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
