import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/search.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class AppSearchBar extends StatefulWidget {
  const AppSearchBar({super.key});

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Explore the World at \nYour Fingertips!",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            InkWell(
              borderRadius: appCircleRaduis,
              onTap: () => _showLocationSearch(context),
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Icon(
                  Icons.search,
                  color: primaryColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _showLocationSearch(BuildContext context) async {
    final searchResult = await showSearch(
      context: context,
      delegate: AppSearch(
        hintText: "Dream, Plan, Go",
        searchTextStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: Colors.grey[500],
            ),
      ),
    );

    _handleSearchResult(searchResult);
  }

  void _handleSearchResult(searchResult) async {
    if (searchResult != null) {}
  }
}
