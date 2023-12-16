// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/categories_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/services/location_service.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';

import 'package:flutter_trip_ui/app/pages/home/widgets/search_bar.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';
import 'package:location/location.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  PlaceService placeService = PlaceService();
  AppLocationService locationService = AppLocationService();

  final List<CategoriesModel> _categories = [
    CategoriesModel(title: 'All', type: ""),
    CategoriesModel(title: 'Parks', type: 'amusement_park'),
    CategoriesModel(title: 'Museums', type: 'museum'),
    CategoriesModel(title: 'Resorts', type: 'lodging'),
    CategoriesModel(title: 'Restaurants', type: 'restaurant'),
  ];

  late LocationData? myLocation;

  num selectedIndex = 0;
  String selectedCategory = "";

  @override
  void initState() {
    super.initState();
  }

  Future getNearbyPopularPlaces(String type) async {
    return await placeService.nearby(type);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppSearchBar(),
              const SizedBox(
                height: 30,
              ),
              _buildCategoryItems(context),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Popular",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Colors.grey.shade800,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        context.push(
                          '/view_all',
                          extra: CategoriesModel(
                              title: "Restaurants", type: 'restaurant'),
                        );
                      },
                      child: Text(
                        "View All",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              _buildPopularItems(),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: appCircleRaduis,
                ),
                child: Column(
                  children: [
                    Text(
                      "Discover more",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      " in your area",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          print("Explore");
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 20, bottom: 10),
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: appCircleRaduis,
                          ),
                          child: Center(
                              child: Text(
                            "Explore",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(
                                  color: Colors.white,
                                ),
                          )),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  SizedBox _buildPopularItems() {
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      height: height * 0.30,
      child: FutureBuilder(
        future: getNearbyPopularPlaces(selectedCategory),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Column(
                children: [
                  Text(
                    "Something went wrong. Please reload the app",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            );
          }

          List<PlaceModel> places = snapshot.data;

          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: places.take(4).length,
            itemBuilder: (context, index) {
              PlaceModel popularItem = places[index];

              String assetRef = popularItem.photos != null
                  ? popularItem.photos![0].photoReference
                  : "";

              String asset = placeService.photoReference(assetRef);
              return _popularItem(context, popularItem, asset);
            },
          );
        },
      ),
    );
  }

  Padding _popularItem(BuildContext context, popularItem, asset) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            context.push('/place-details', extra: popularItem);
          },
          child: Container(
            width: width * 0.70,
            decoration: BoxDecoration(
              borderRadius: appCircleRaduis,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: appCircleRaduis,
                  child: Stack(
                    children: [
                      CachedNetworkImage(
                        height: height * 0.20,
                        width: double.infinity,
                        fit: BoxFit.fill,
                        imageUrl: asset,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(color: primaryColor),
                        ),
                        errorWidget: (context, url, error) => const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Error loading image.",
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        top: 15,
                        right: 15,
                        child: _heartIcon(),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  popularItem.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.pin_drop_rounded,
                          size: 15,
                          color: primaryColor,
                        ),
                        SizedBox(
                          width: width * 0.5,
                          child: Text(
                            popularItem.vicinity,
                            overflow: TextOverflow.ellipsis,
                            style:
                                Theme.of(context).textTheme.bodySmall!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade600,
                                    ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          size: 15,
                          color: primaryColor,
                        ),
                        Text(
                          popularItem.rating,
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Material _heartIcon() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          // print(rating.toString());
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.2),
          ),
          child: Image.asset(
            "assets/images/heart.png",
          ),
        ),
      ),
    );
  }

  Column _buildCategoryItems(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Categories",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            itemBuilder: (context, index) {
              CategoriesModel category = _categories[index];
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: _buildListItems(category, index),
              );
            },
          ),
        )
      ],
    );
  }

  Material _buildListItems(CategoriesModel category, index) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: appCircleRaduis,
        onTap: () {
          if (selectedIndex == index) {
            return;
          }
          setState(() {
            selectedIndex = index;
            selectedCategory = category.type;
          });
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          height: 100,
          decoration: BoxDecoration(
            borderRadius: appCircleRaduis,
            border: Border.all(
                color: primaryColor, width: selectedIndex != index ? 1 : 1.6),
          ),
          child: Center(
            child: Text(
              category.title,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.grey.shade800,
                    fontWeight: selectedIndex != index
                        ? FontWeight.normal
                        : FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
