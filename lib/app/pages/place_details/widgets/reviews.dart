import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_details_model.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class Reviews extends StatelessWidget {
  final List<Review>? reviews;
  const Reviews({super.key, this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (reviews == null) ...{
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: CircularProgressIndicator(
                color: primaryColor,
              ),
            ),
          )
        } else ...{
          Expanded(
            child: ListView.builder(
              itemCount: reviews!.length,
              itemBuilder: (context, idx) {
                Review review = reviews![idx];
                return Column(
                  children: [
                    ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: review.profilePhotoUrl,
                        height: 50,
                        width: 50,
                      ),
                      title: Text(
                        review.authorName,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            review.rating.toStringAsFixed(1),
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.star,
                            color: primaryColor,
                            size: 14,
                          )
                        ],
                      ),
                      trailing: Text(
                        review.relativeTimeDescription,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: primaryColor, fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 12),
                        decoration: BoxDecoration(
                            color: review.text.isNotEmpty
                                ? primaryColor.withOpacity(0.2)
                                : Colors.transparent,
                            borderRadius: appCircleRaduis),
                        child: review.text.isNotEmpty
                            ? Text(
                                review.text,
                                style: Theme.of(context).textTheme.bodySmall,
                              )
                            : const Text(
                                "No comments provided",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 10,
                                ),
                              ),
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    )
                  ],
                );
              },
            ),
          )
        }
      ],
    );
  }
}
