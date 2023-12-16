import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/bottom_bar.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/cart.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/favourite.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/home.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/profile.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController pageController = PageController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final StreamSubscription<User?> _authStateSubscription;
  num? bottomNavPage = 0;

  List pages = [
    const HomeView(),
    const CartView(),
    const FavouriteView(),
    const ProfileView(),
  ];

  @override
  void initState() {
    _checkUserState();
    pageController.addListener(() {
      num? page = pageController.page?.round();
      if (page != bottomNavPage) {
        setState(() {
          bottomNavPage = page;
        });
      }
    });

    super.initState();
  }

  void _checkUserState() {
    _authStateSubscription = _auth.authStateChanges().listen((User? user) {
      if (user == null) {
        context.go("/sign-in");
      }
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    _authStateSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: BottomBar(
        currentPage: bottomNavPage,
        onTap: onTap,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: PageView.builder(
          controller: pageController,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return pages[index];
          },
        ),
      ),
    );
  }

  void onTap(num idx) {
    pageController.animateToPage(
      idx.toInt(),
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
