import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_details_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/additional_info.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/gallery.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/reviews.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/slivers/image_builder.dart';
import 'package:flutter_trip_ui/app/services/place_service.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class PlaceDetails extends StatefulWidget {
  final PlaceModel place;
  const PlaceDetails({
    required this.place,
    super.key,
  });

  @override
  State<PlaceDetails> createState() => _PlaceDetailsState();
}

class _PlaceDetailsState extends State<PlaceDetails>
    with SingleTickerProviderStateMixin {
  PlaceService placeService = PlaceService();
  String asset = "";
  TabController? tabController;

  PlaceDetailsModel? placeDetails;

  @override
  void initState() {
    _buildImage();
    fetchPlaceDetails();

    tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _buildImage() {
    setState(() {
      asset = widget.place.photos?.isNotEmpty == true
          ? placeService.photoReference(widget.place.photos![0].photoReference)
          : "";
    });
  }

  Future fetchPlaceDetails() async {
    PlaceDetailsModel? details =
        await placeService.placeDetails(widget.place.placeId);

    setState(() {
      placeDetails = details;
    });
  }

  bool buildTitle(bool showTitle) {
    return showTitle;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          ImageBuilder(
            asset: asset,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.place.name,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.pin_drop_rounded,
                        size: 20,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      SizedBox(
                        width: width * 0.80,
                        child: Text(
                          widget.place.vicinity,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Colors.grey.shade600),
                        ),
                      ),
                    ],
                  ),
                  AdditionalInfo(
                    place: widget.place,
                    description: Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.1),
                          borderRadius: appCircleRaduis),
                      child: Text(
                        placeDetails?.editorialSummary?.overview.toString() ??
                            "No summary available.",
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            delegate: _MySliverPersistendHeader(
              TabBar(
                controller: tabController,
                indicatorColor: primaryColor,
                splashBorderRadius: appCircleRaduis,
                labelColor: primaryColor,
                overlayColor:
                    MaterialStatePropertyAll(primaryColor.withOpacity(0.2)),
                labelStyle: Theme.of(context).textTheme.bodyMedium,
                tabs: const [
                  Tab(
                    text: "Reviews",
                  ),
                  Tab(
                    text: "Gallery",
                  ),
                ],
              ),
            ),
            pinned: true,
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: tabController,
              children: [
                Reviews(reviews: placeDetails?.reviews),
                Gallery(photos: placeDetails?.photos),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _MySliverPersistendHeader extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _MySliverPersistendHeader(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      decoration: const BoxDecoration(color: Colors.white),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_MySliverPersistendHeader oldDelegate) {
    return false;
  }
}
