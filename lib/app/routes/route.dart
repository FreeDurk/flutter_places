import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/home_page.dart';
import 'package:flutter_trip_ui/app/pages/home/models/categories_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/photo_model.dart';
import 'package:flutter_trip_ui/app/pages/home/models/place_model.dart';
import 'package:flutter_trip_ui/app/pages/home/pages/view_all.dart';
import 'package:flutter_trip_ui/app/pages/onboard/onboard.dart';
import 'package:flutter_trip_ui/app/pages/onboard/sign_in.dart';
import 'package:flutter_trip_ui/app/pages/place_details/place_details.dart';
import 'package:flutter_trip_ui/app/pages/place_details/widgets/photo_view.dart';
import 'package:go_router/go_router.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const Onboard();
      },
      routes: <RouteBase>[
        GoRoute(
          name: 'home',
          path: 'home',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const HomePage(),
          ),
        ),
        GoRoute(
          name: 'view-all',
          path: 'view_all',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: ViewAll(categoryModel: state.extra as CategoriesModel),
          ),
        ),
        GoRoute(
          name: 'place_details',
          path: 'place-details',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: PlaceDetails(
              place: state.extra! as PlaceModel,
            ),
          ),
        ),
        // for later use only, not use on current update
        GoRoute(
          name: 'photo_view',
          path: 'photo-view/:currentIndex',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: PhotoView(
              photos: state.extra! as List<Photo>,
              currentTapPhoto: int.parse(state.pathParameters['currentIndex']!),
            ),
          ),
        ),
        GoRoute(
          name: 'sign_in',
          path: 'sign-in',
          pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
            context: context,
            state: state,
            child: const SignIn(),
          ),
        ),
      ],
    ),
  ],
);

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 400),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
      position: animation.drive(
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).chain(
          CurveTween(curve: Curves.easeIn),
        ),
      ),
      child: child,
    ),
  );
}
