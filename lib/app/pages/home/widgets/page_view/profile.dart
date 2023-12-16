import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_ui/app/pages/home/widgets/page_view/profile_widgets/item_tiles.dart';
import 'package:flutter_trip_ui/app/services/auth/facebook/app_facebook_auth_provider.dart';
import 'package:flutter_trip_ui/app/services/auth/app_auth_provider.dart';
import 'package:flutter_trip_ui/app/services/auth/google/app_google_auth_provider.dart';
import 'package:flutter_trip_ui/constants/theme_data.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late AppAuthProvider appAuthProvider;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  void initState() {
    final List<UserInfo> info = firebaseAuth.currentUser!.providerData;

    switch (info.first.providerId) {
      case "google.com":
        appAuthProvider = AppGoogleAuthProvider();
        break;
      case "facebook.com":
        appAuthProvider = AppFbAuthProvider();
        break;
      default:
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<User?>(
          stream: firebaseAuth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            final User? currentUser = snapshot.data;

            if (currentUser != null) {
              return _buildProfile(currentUser);
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Padding _buildProfile(User? currentUser) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    height: 80,
                    width: 80,
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        currentUser!.photoURL.toString(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        currentUser.displayName.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: primaryColor,
                            ),
                      ),
                      // Text(
                      //   currentUser.email.toString(),
                      //   overflow: TextOverflow.ellipsis,
                      //   style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      //         fontWeight: FontWeight.bold,
                      //         fontStyle: FontStyle.italic,
                      //         fontSize: 10,
                      //         color: primaryColor.withOpacity(0.6),
                      //       ),
                      // )
                    ],
                  ),
                ],
              ),
              _buildLogoutButton(),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Divider(
            height: 3,
            color: Colors.grey.shade300,
            thickness: 1.4,
          ),
          const SizedBox(
            height: 30,
          ),
          const ItemTiles()
        ],
      ),
    );
  }

  Material _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: appCircleRaduis,
        onTap: () async {
          await appAuthProvider.signOut();
        },
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Image.asset(
                "assets/images/logout.png",
                height: 35,
                width: 35,
                color: Colors.green,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
