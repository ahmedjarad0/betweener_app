import 'package:betweener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

import '../../models/follow.dart';

class FollowersScreen extends StatefulWidget {
  static String id = '/followers_screen';

  final List<FollowerElement>? followers;
  final String title;

  const FollowersScreen({super.key, this.followers, required this.title});

  @override
  State<FollowersScreen> createState() => _FollowersScreenState();
}

class _FollowersScreenState extends State<FollowersScreen> {
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
                itemCount: widget.followers!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: kLightPrimaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: Text(widget.followers![index].name!),
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
