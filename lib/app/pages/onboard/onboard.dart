import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_trip_ui/app/pages/onboard/onboard_screens/onboarding_pages.dart';
import 'package:flutter_trip_ui/app/services/location_service.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with SingleTickerProviderStateMixin {
  AppLocationService locationServe = AppLocationService();
  late final SharedPreferences prefs;
  final List<String> headline = [
    "Embark on \nEndless \nAdventures",
    "Tailored Tours \nfor Every \nExplorer"
  ];
  final PageController _pageController = PageController();
  @override
  void initState() {
    super.initState();
    appLocationRequest();
    checkOnboardingStatus();
  }

  void checkOnboardingStatus() async {
    prefs = await SharedPreferences.getInstance();

    final bool doneOnboarding = prefs.getBool('done_on_boarding') ?? false;

    if (doneOnboarding) {
      moveToSignIn();
    }
  }

  void moveToSignIn() {
    context.go("/sign-in");
  }

  void doneOnboarding() async {
    final donePref = await SharedPreferences.getInstance();
    await donePref.setBool('done_on_boarding', true);
  }

  appLocationRequest() async {
    await locationServe.checkService();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: CachedNetworkImageProvider(
                "https://firebasestorage.googleapis.com/v0/b/ryde-navi.appspot.com/o/onboarding.jpg?alt=media&token=1344da5b-8e02-4981-a041-153d2abff4d9"),
            fit: BoxFit.fill,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: height * 0.7,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 2,
                  itemBuilder: (context, index) =>
                      OnboardingPages(headline: headline[index]),
                ),
              ).animate().slide(
                    begin: const Offset(2, 0),
                    end: const Offset(0, 0),
                    delay: 900.ms,
                  ),
              _buildExploreText(width, height, context)
            ],
          ),
        ),
      ),
    );
  }

  Container _buildExploreText(
      double width, double height, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      margin: EdgeInsets.only(bottom: height * 0.05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(
                children: [
                  Text(
                    "Let's explore",
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                  ).animate().fadeIn(delay: 900.ms),
                  const SizedBox(
                    height: 10,
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: headline.length,
                    effect: const WormEffect(
                      dotColor: Colors.white,
                      activeDotColor: primaryColor,
                      dotHeight: 12,
                      dotWidth: 12,
                    ),
                  )
                ],
              )
            ],
          ),
          _buildExploreButton(context).animate().fadeIn(delay: 900.ms)
        ],
      ),
    );
  }

  Material _buildExploreButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: () {
          if (_pageController.page != headline.length - 1) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn,
            );
            return;
          }
          doneOnboarding();
          context.go("/sign-in");
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 3),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Image.asset(
              "assets/images/arrow.png",
            ),
          ),
        ),
      ),
    );
  }
}
