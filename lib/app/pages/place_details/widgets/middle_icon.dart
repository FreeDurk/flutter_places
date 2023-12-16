import 'package:flutter/material.dart';

class MiddleIcon extends StatelessWidget {
  final String img;
  final String title;
  final String subTitle;
  const MiddleIcon({
    super.key,
    required this.img,
    required this.subTitle,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.rectangle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            img,
            height: 35,
            width: 35,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodySmall!
                .copyWith(color: Colors.black, fontWeight: FontWeight.w700),
          ),
          Text(
            subTitle,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }
}
