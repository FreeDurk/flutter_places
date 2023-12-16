import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/favourite_widgets/empty_favourites.dart';

class FavouriteView extends StatefulWidget {
  const FavouriteView({super.key});

  @override
  State<FavouriteView> createState() => _FavouriteViewState();
}

class _FavouriteViewState extends State<FavouriteView> {
  bool emptyFavourite = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: emptyFavourite ? const EmptyFavourites() : const Placeholder(),
    );
  }
}
