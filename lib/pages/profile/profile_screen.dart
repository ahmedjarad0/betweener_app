import 'dart:async';

import 'package:betweener_app/controllers/api/follow_api_controller.dart';
import 'package:betweener_app/controllers/api/links_api_controller.dart';
import 'package:betweener_app/controllers/api/user_controller.dart';
import 'package:betweener_app/models/follow.dart';
import 'package:betweener_app/models/user.dart';
import 'package:betweener_app/pages/follow/followers_screen.dart';
import 'package:betweener_app/pages/follow/following_screen.dart';
import 'package:betweener_app/pages/link/edit_link_screen.dart';
import 'package:betweener_app/pages/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../core/util/constants.dart';
import '../../models/links.dart';
import '../../provider/follow_provider.dart';

class ProfileScreen extends StatefulWidget {
  static String id = '/profile_screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future<UserAuth> userAuth;

  late Future<List<Links>> link;

  late Future<Follow> follow;

  @override
  void initState() {
    // TODO: implement initState
    userAuth = getUser();
    link = LinksApiController().getLinks(context);
    follow = FollowApiController().getFollow();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            FutureBuilder<List<dynamic>>(
              future: Future.wait([userAuth, follow]),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final Follow followModel = snapshot.data![1];
                  final UserAuth user = snapshot.data![0];
                  print(user.user!.name);
                  return Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: kPrimaryColor,
                    ),
                    child: Row(children: [
                      const CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/img/man.png'),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${snapshot.data![0].user!.name}',
                                style: GoogleFonts.roboto(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const SizedBox(
                                width: 70,
                              ),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              EditProfileScreen(
                                                  userAuth: user),
                                        ));
                                    // Navigator.pushNamed(context, EditProfileScreen.id,arguments: {
                                    //   'name': user.user!.name,
                                    //   'email': user.user!.email,
                                    // }).then((_) {
                                    //   final users = getUser();
                                    //
                                    //   setState(() {
                                    //     users;
                                    //   });
                                    // });
                                  },
                                  icon: const Icon(
                                    Icons.edit_outlined,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          Text(
                            snapshot.data![0].user!.email,
                            style: GoogleFonts.roboto(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (followModel.following != null &&
                                      followModel.following!.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => FollowingScreen(
                                              title: 'Following',
                                              following:
                                                  followModel.following!),
                                        ));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(42, 17),
                                    backgroundColor: kSecondaryColor),
                                child: const Text(
                                  'following',
                                  style: TextStyle(color: kOnSecondaryColor),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 30,
                                height: 19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kSecondaryColor,
                                ),
                                child: Text(
                                  '${followModel.followingCount}',
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: kOnSecondaryColor),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  if (followModel.followers != null &&
                                      followModel.followers!.isNotEmpty) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FollowersScreen(
                                                  title: 'Followers',
                                                  followers:
                                                      followModel.followers!,
                                                )));
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(42, 17),
                                    backgroundColor: kSecondaryColor),
                                child: const Text(
                                  'followers',
                                  style: TextStyle(
                                    color: kOnSecondaryColor,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Container(
                                width: 30,
                                height: 19,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: kSecondaryColor,
                                ),
                                child: Text(
                                  '${snapshot.data![1].followersCount}',
                                  textAlign: TextAlign.center,
                                  style:
                                      const TextStyle(color: kOnSecondaryColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ]),
                  );
                }
                return const SizedBox();
              },
            ),
            const SizedBox(
              height: 30,
            ),
            FutureBuilder(
              future: LinksApiController().getLinks(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData) {
                  return Expanded(
                    child: SlidableAutoCloseBehavior(
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(12),
                                    onPressed: (context) {
                                      Navigator.pushNamed(
                                          context, EditLinkScreen.id,
                                          arguments: {
                                            'id': '${snapshot.data![index].id}',
                                            'title':
                                                '${snapshot.data![index].title}',
                                            'link':
                                                '${snapshot.data![index].link}',
                                          }).then((_) {
                                        final link = LinksApiController()
                                            .getLinks(context);

                                        setState(() {
                                          link;
                                        });
                                      });
                                    },
                                    backgroundColor: kSecondaryColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.edit_outlined,
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(12),
                                    onPressed: (context) async {
                                      await LinksApiController()
                                          .deleteLinks(
                                              id: '${snapshot.data![index].id}')
                                          .then((value) {
                                        final link = LinksApiController()
                                            .getLinks(context);
                                        setState(() {
                                          link;
                                        });
                                      });
                                    },
                                    backgroundColor: kDangerColor,
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                  ),
                                ],
                              ),
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 13),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: kLightPrimaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data![index].title}',
                                      style: GoogleFonts.roboto(
                                          color: kPrimaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${snapshot.data![index].link}',
                                      style: GoogleFonts.roboto(
                                          color: kPrimaryColor, fontSize: 10),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No Data,',
                      style: TextStyle(fontSize: 22),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
