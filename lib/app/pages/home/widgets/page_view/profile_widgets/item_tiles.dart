import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class ItemTiles extends StatelessWidget {
  const ItemTiles({super.key});

  @override
  Widget build(BuildContext context) {
    List<ItemModel> items = [
      ItemModel(asset: "assets/images/bottom_user.png", title: "Profile"),
      ItemModel(asset: "assets/images/card.png", title: "My Cards"),
      ItemModel(asset: "assets/images/settings.png", title: "Settings")
    ];

    return SizedBox(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: items.length,
        itemBuilder: (context, idx) {
          ItemModel item = items[idx];
          return ListTile(
            onTap: () {
              print(item.title);
            },
            trailing: Image.asset(
              "assets/images/right_arrow.png",
              height: 23,
              width: 23,
              color: primaryColor,
            ),
            title: Text(
              item.title,
              style:
                  Theme.of(context).textTheme.bodySmall!.copyWith(fontSize: 16),
            ),
            leading: Image.asset(
              item.asset,
              color: Colors.black,
              height: 30,
              width: 30,
            ),
          );
        },
      ),
    );
  }
}

class ItemModel {
  final String title;
  final String asset;

  ItemModel({required this.title, required this.asset});
}
