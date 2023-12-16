import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/services/auth/facebook/app_facebook_auth_provider.dart';
import 'package:flutter_trip_ui/app/services/auth/app_auth_provider.dart';
import 'package:flutter_trip_ui/app/services/auth/google/app_google_auth_provider.dart';
import 'package:flutter_trip_ui/app/widgets/app_button.dart';
import 'package:flutter_trip_ui/app/widgets/app_header.dart';
import 'package:flutter_trip_ui/app/widgets/input_field.dart';
import 'package:flutter_trip_ui/app/widgets/login_icon.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';
import 'package:go_router/go_router.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AppAuthProvider googleAuth = AppGoogleAuthProvider();
  final AppAuthProvider fbAuth = AppFbAuthProvider();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late final StreamSubscription<User?> _authStateSubscription;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  bool isPassword = false;

  @override
  void initState() {
    _authStateSubscription = _auth.authStateChanges().listen((User? user) {
      if (user != null) {
        _goToHomePage();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _authStateSubscription.cancel();
    super.dispose();
  }

  void _goToHomePage() {
    context.go("/home");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppHeader(title: "Log In"),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: AppInputField(
                  title: const Text(
                    "Email",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  placeholder: "Enter your emaill address.",
                  obscureText: false,
                  onChanged: (val) {},
                  iconTap: () {},
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: AppInputField(
                  title: const Text(
                    "Password",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: primaryColor,
                    ),
                  ),
                  placeholder: "Enter your password.",
                  obscureText: true,
                  onChanged: (val) {},
                  iconTap: () {
                    setState(() {
                      isPassword = !isPassword;
                    });
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "Forgot Password?",
                      style: TextStyle(
                        color: blkOpacity,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: AppButton(
                      text: "Sign in",
                      onTap: () async {},
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Don't have an account? Sign Up",
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Sign up via",
                    style: TextStyle(color: blkOpacity, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      LoginIcon(
                        image: "assets/images/facebook.png",
                        child: const Text("Facebook"),
                        onTap: () async {
                          await fbAuth.signIn();
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      LoginIcon(
                        image: "assets/images/google.png",
                        child: const Text("Google"),
                        onTap: () async {
                          analytics.logEvent(
                              name: 'sign_in_screen',
                              parameters: {'screen_name': 'sign_in'});
                          try {
                            await googleAuth.signIn();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  e.toString(),
                                ),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
