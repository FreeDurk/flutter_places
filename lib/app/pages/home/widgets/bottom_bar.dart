import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class BottomBar extends StatelessWidget {
  final num? currentPage;
  final Function(num idx) onTap;
  const BottomBar({required this.currentPage, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;

    List bottomItemsAsset = [
      "assets/images/bottom_home.png",
      "assets/images/bottom_cart.png",
      "assets/images/bottom_heart.png",
      "assets/images/bottom_user.png"
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, top: 10),
        decoration: BoxDecoration(
          borderRadius: appCircleRaduis,
          color: primaryColor,
        ),
        height: height * 0.08,
        width: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bottomItemsAsset
              .asMap()
              .entries
              .map((item) => _buildNavigationItem(item.value, item.key))
              .toList(),
        ),
      ),
    );
  }

  Material _buildNavigationItem(String asset, num idx) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: appCircleRaduis,
        onTap: () {
          onTap(idx);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: appCircleRaduis,
            color: currentPage == idx
                ? Colors.white.withOpacity(0.3)
                : Colors.transparent,
          ),
          padding: const EdgeInsets.all(12),
          child: _buildBottomNavigationImage(asset),
        ),
      ),
    );
  }

  Image _buildBottomNavigationImage(String asset) => Image.asset(
        asset,
        height: 30,
        width: 30,
      );
}
