import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  final String title;
  const AppHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120, left: 40),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
