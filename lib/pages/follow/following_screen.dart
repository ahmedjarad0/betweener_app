import 'package:betweener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

import '../../models/follow.dart';

class FollowingScreen extends StatefulWidget {
  static String id = '/following_screen';

  final List<FollowerElement>? following;
  final String title;

  const FollowingScreen({super.key, this.following, required this.title});

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.following!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: kLightPrimaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(widget.following![index].name!),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
