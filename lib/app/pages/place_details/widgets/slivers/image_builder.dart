import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';

class ImageBuilder extends StatefulWidget {
  final String asset;
  const ImageBuilder({super.key, required this.asset});
  @override
  State<ImageBuilder> createState() => _ImageBuilderState();
}

class _ImageBuilderState extends State<ImageBuilder> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      actions: [
        IconButton(
          onPressed: () {},
          icon: Image.asset("assets/images/bottom_heart.png"),
        ),
      ],
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(
          Icons.backspace,
          color: primaryColor,
          size: 30,
        ),
      ),
      elevation: 0,
      pinned: true,
      stretch: false,
      expandedHeight: 250,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Image(
          image: CachedNetworkImageProvider(widget.asset),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
