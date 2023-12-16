import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class LoginIcon extends StatelessWidget {
  final String image;
  final Widget child;
  final Function()? onTap;
  const LoginIcon(
      {required this.child, required this.image, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: appCircleRaduis,
        onTap: onTap,
        child: Container(
            width: width * 0.40,
            height: 50,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.3),
              borderRadius: appCircleRaduis,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  height: height * 0.050,
                  width: 50,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: Image.asset(image),
                ),
                child
              ],
            )),
      ),
    );
  }
}
